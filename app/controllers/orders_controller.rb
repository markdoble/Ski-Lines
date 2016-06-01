class OrdersController < ApplicationController
  layout "order_layout"
  before_action :set_order, only: [:show, :edit, :update, :destroy]




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
    redirect_to root_path
  end


# Cart functions End


  def index
    @order = Order.new
    if session[:order_session]
        if session[:order_expiry] < Time.current
          session.delete(:order_session)
          session.delete(:order_expiry)
        else
            @order_session = session[:order_session]
        end
    else
      @order_session = nil
    end
    find_or_create_cart
  end

  def show
    @navbar = true
    @order = Order.find(params[:id])
  end

  def new
    respond_to do |format|
      format.js
      format.html
    end
  end


  def edit
    find_or_create_cart
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    nonce = params[:payment_method_nonce]
    amount = '%.2f' % @order.amount.to_s
    @transaction = Braintree::Transaction.sale(
      amount: amount,
      payment_method_nonce: nonce,
      :options => {
          :submit_for_settlement => true
        },
        :customer => {
          :first_name => params[:cust_first_name],
          :last_name => params[:cust_last_name]
        }
    )
    @order.transaction_id = @transaction.transaction.id

    if @transaction.success?
        respond_to do |format|
          if @order.save

            create_order_session
            update_inventory(@order)
            order_emails(@order)

            format.html { redirect_to cart_path }
            format.json {render json: @order }
            session[:cart] = nil
          else
            Braintree::Transaction.void(@transaction.transaction.id)
            format.html { render action: 'edit' }
            format.json { render json: @order.errors, status: :unprocessable_entity }

            find_or_create_cart

          end
        end
    else
      flash[:alert] = 'There was a problem processing your payment. Please try again!'
      find_or_create_cart
      render 'edit'
    end
  end

  private
      def set_order
        @orders = Order.find(params[:id])
      end

      def order_params
        params.require(:order).permit(:street_address, :prov_state, :country, :city, :postal_zip, :cust_first_name, :cust_last_name, :cust_email, :cust_phone, :status, :marketing_optout, :amount, :sales_tax, :shipping, :merchant_orders_attributes => [:id, :user_id, :order_id, :product_id, :order_status, :delivery_method, :customer_comments], :product_ids => [], :order_units_attributes => [:id, :unit_id, :order_id, :quantity])
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
           OrderMailer.merchant_purchase_orders(@order, user).deliver
        end
        OrderMailer.customer_purchase_order(@order).deliver
      end

      def create_order_session
        session[:order_session] = @order.id
        session[:order_expiry] = Time.current + 30
      end

end
