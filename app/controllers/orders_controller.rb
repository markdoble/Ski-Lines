class OrdersController < ApplicationController
  layout "order_layout"
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_filter :find_or_create_cart, only: [:index, :edit, :create, :update, :payment_form, :customer_details_form, :confirmation]


# Cart FUnctions
  def add
    id = params[:id]
    # if the cart has already been created, use the existing cart, else create a new cart
    if session[:cart] then
      cart = session[:cart]
    else
      session[:cart] = {}
      cart = session[:cart]
    end
    # if the product unit has already been added to the cart, increment the value else set
    if cart[id] then
      cart[id] = cart[id] + 1
    else
      cart[id] = 1
    end
    redirect_to :action => :index
  end

  def remove
    id = params[:id]
    # if the cart has already been created, use the existing cart, else create a new cart
    if session[:cart] then
      cart = session[:cart]
    else
      session[:cart] = {}
      cart = session[:cart]
    end
    # if the product unit has already been added to the cart, increment the value else set
    if cart[id] then
      cart.delete(id)
    else
      cart[id] = 1
    end
    redirect_to :action => :index
  end

  def clearCart
    session[:cart] = nil
    redirect_to root_path
  end

  def clearOrderSession
    session.delete(:order_session)
    session.delete(:order_expiry)
    session.delete(:order_confirmation_session)
    redirect_to shop_path
  end
# Cart functions End

  def index
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save(validate: false)
        create_order_session
        format.html { redirect_to orders_customer_details_form_path(@order) }
        format.json { render json: @order }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update

  end

  def customer_details_form
    @order = Order.find_by_id(session[:order_session])
    if session[:order_session]
      @order_session = session[:order_session]
    else
      @order_session = nil
      redirect_to :action => :index
    end
  end

  def create_customer_details
    @order = Order.find(params[:id])
    # calculate sales_tax, amount, and shipping - eventually put in private method with TaxJar API
    @order.update_attributes(
      :sales_tax => calculate_sales_tax(@order),
      :shipping => calculate_shipping(@order),
      :amount => calculate_total_amount(@order)
    )
    respond_to do |format|
      if @order.update_attributes(order_params)
        format.html { redirect_to orders_payment_form_path(@order) }
        format.json { render json: @order }
      else
        format.html { redirect_to orders_order_form_path(@order) }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def payment_form
    @order = Order.find_by_id(session[:order_session])
    if session[:order_session]
      @order_session = session[:order_session]
    else
      @order_session = nil
      redirect_to :action => :index
    end
  end

  def create_payment
    @order = Order.find(params[:id])
    nonce = params[:payment_method_nonce]
    amount = '%.2f' % @order.amount.to_s
    @transaction = Braintree::Transaction.sale(
      amount: amount,
      payment_method_nonce: nonce,
      :options => {
          :submit_for_settlement => true
        }
    )
    @order.update_attributes(transaction_id: @transaction.transaction.id)
    respond_to do |format|
      if @transaction.success?
        #update_inventory(@order)
        #order_emails(@order)
        create_order_confirmation_session
        @order.update_attributes(success: true)
        session.delete(:cart)
        format.html { redirect_to orders_confirmation_path(@order) }
        format.json { render json: @order }
      else
        @order.update_attributes(success: false)
        Braintree::Transaction.void(@transaction.transaction.id)
        flash[:error] = "There was a problem processing your payment. Please try again!"
        format.html { redirect_to orders_payment_path(@order) }
      end
    end
  end

  def confirmation
    @order = Order.find_by_id(session[:order_confirmation_session])
    if session[:create_order_confirmation_session]
      @create_order_confirmation_session = true
    else
      @create_order_confirmation_session = false
    end
  end



  private
      def set_order
        @orders = Order.find(params[:id])
      end

      def order_params
        params.require(:order).permit(:street_address, :prov_state, :country, :city, :postal_zip, :cust_first_name, :cust_last_name, :cust_email, :cust_phone, :status, :marketing_optout, :amount, :sales_tax, :shipping, :success, :merchant_orders_attributes => [:id, :user_id, :order_id, :product_id, :order_status, :delivery_method, :customer_comments], :product_ids => [], :order_units_attributes => [:id, :unit_id, :order_id, :quantity])
      end

      def find_or_create_cart
        if session[:cart] then
          @cart = session[:cart]
        else
          @cart = {}
        end
      end

      def update_inventory(order)
        @order = order
        @order.order_units.each do |d|
          if d.unit.quantity_sold.nil?
            d.unit.update_attributes(quantity_sold: 0)
          end
          d.unit.update_attributes(quantity: d.unit.quantity-d.quantity)
          d.unit.update_attributes(quantity_sold: d.unit.quantity_sold+d.quantity)
        end
      end

      def order_emails(order)
        @order = order
        @email_users = []
        @order.order_units.where.not(quantity: 0).each do |ou|
          @email_users << ou.unit.product.user
        end
        @email_users.uniq.each do |user|
           OrderMailer.merchant_purchase_orders(@order, user).deliver_later
        end
        OrderMailer.customer_purchase_order(@order).deliver_later
      end

      def create_order_session
        session[:order_session] = @order.id
        session[:order_expiry] = Time.current + 500
      end

      def create_order_confirmation_session
        session[:order_confirmation_session] = @order.id
        session[:order_confirmation_session_expiry] = Time.current + 500
      end

      def calculate_total_amount(order)
        sub_total = 0
        order.order_units.where.not(quantity: 0).each do |p|
          sub_total += p.unit.product.price*p.quantity
        end
        sub_total+calculate_shipping(order)+calculate_sales_tax(order)
      end

      def calculate_shipping(order)
        shipping_total = 0
        order.order_units.where.not(quantity: 0).each do |p|
          shipping_total += p.unit.product.shipping_charge*p.quantity
        end
        shipping_total
      end

      def calculate_sales_tax(order)
        require 'taxjar'
        client = Taxjar::Client.new(api_key: ENV['TAXJAR_APIKEY'])
        sales_tax_total = 0
        order.order_units.where.not(quantity: 0).each do |p|
          taxjar_result = client.tax_for_order({
              :to_country => 'CA',
              :to_city => p.order.city,
              :to_state => 'ON',
              :to_zip => p.order.postal_zip,
              :from_country => 'CA',
              :from_zip => p.unit.product.user.zip_postal,
              :from_city => p.unit.product.user.city,
              :from_state => 'ON',
              :amount => p.unit.product.price,
              :shipping => p.unit.product.shipping_charge
          })
          sales_tax_total += taxjar_result.amount_to_collect*p.quantity
        end
        sales_tax_total
      end

end
