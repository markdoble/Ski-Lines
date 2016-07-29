class OrdersController < ApplicationController
  layout "order_layout"
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_filter :find_or_create_cart, only: [:index, :edit, :create, :update]


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
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        create_order_session
        format.html { redirect_to orders_payment_path }
        format.json {render json: @order }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def payment
    @order = Order.find(params[:id])
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
  end

  def transaction
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
        update_inventory(@order)
        order_emails(@order)
        @order.update_attributes(success: true)
        session[:cart] = nil
        format.html { redirect_to cart_path }
        format.json {render json: @order }
      else
        @order.update_attributes(success: false)
        Braintree::Transaction.void(@transaction.transaction.id)
        flash[:error] = "There was a problem processing your payment. Please try again!"
        redirect_to orders_payment_path
      end
    end

    if verify_amount(@order)
      format.html { redirect_to cart_path }
      format.json {render json: @order }
      session[:cart] = nil
    else
    end
  end

  def confirmation

  end

  def update
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
            if @order.save
                if verify_amount(@order)
                  create_order_session
                  update_inventory(@order)
                  order_emails(@order)
                  @order.update_attributes(success: true)
                  format.html { redirect_to cart_path }
                  format.json {render json: @order }
                  session[:cart] = nil
                else
                  @order.update_attributes(success: false)
                  Braintree::Transaction.void(@transaction.transaction.id)
                  format.html { render action: 'edit' }
                  @order.errors.add(:base, "Order amount is incorrect! Please try again.")
                  format.json { render json: @order.errors, status: :unprocessable_entity }
                end
            else
              @order.update_attributes(success: false)
              Braintree::Transaction.void(@transaction.transaction.id)
              format.html { render action: 'edit' }
              format.json { render json: @order.errors, status: :unprocessable_entity }
            end
        else
          @order.update_attributes(success: false)
          format.html { render action: 'edit' }
          @order.errors.add(:base, "There was a problem processing your payment. Please try again!")
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
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
        session[:order_expiry] = Time.current + 30
      end

      def verify_amount(order)
        # actual_amount is the amount the credit card has been charged.
        # test_amount is the server side calculation of the amount charged.
        actual_amount = order.amount.to_f
        difference = (actual_amount.to_f - (calculate_test_order_amount(order)).to_f).abs
        # ternary operator reminder: if_this_is_a_true_value ? then_the_result_is_this : else_it_is_this
        # give a margin of error for rounding of 0.02;
        # if difference is more than 0.02, return false, else true
        (difference > 0.02) ? false : true
      end

      def calculate_test_order_amount(order)
        test_amount = 0
        order_units_array = []
        order.order_units.where.not(quantity: 0).each do |f|
          order_units_array << f.unit
        end
        order.merchant_orders.each do |f|
          case f.order.country
          when "United States of America"
            shipping_factor = 1.5
          else
            shipping_factor = 1
          end
          order_units_array.each do |ff|
            if f.product_id == ff.product_id
              test_amount += ((ff.product.price + (ff.product.shipping_charge*shipping_factor))*(1+tax_rate_calc(f).to_f))
            else
              next
            end
          end
        end
        test_amount
      end

      def tax_rate_calc(f)
        merchant_location = f.user.state_prov
        if f.delivery_method == "In Store Pick-Up"
          customer_location = f.user.state_prov
          customer_country = f.user.country
        else
          customer_location = f.order.prov_state
          customer_country = f.order.country
        end
        if ["New Brunswick", "Newfoundland and Labrador", "Nova Scotia", "Ontario", "Prince Edward Island", 'Northwest Territories', 'Nunavut', 'Yukon'].include? customer_location
          if customer_location == "New Brunswick" then tax_rate = 0.13
          elsif customer_location == "Newfoundland and Labrador" then tax_rate = 0.13
          elsif customer_location == "Nova Scotia" then tax_rate = 0.15
          elsif customer_location == "Ontario" then tax_rate = 0.13
          elsif customer_location == "Prince Edward Island" then tax_rate = 0.14
          elsif ['Northwest Territories', 'Nunavut', 'Yukon'].includes? customer_location then tax_rate = 0.05
          end
        elsif customer_location == merchant_location
          if customer_location == "Alberta" then tax_rate = 0.05
          elsif customer_location == "British Columbia" then tax_rate = 0.12
          elsif customer_location == "Manitoba" then tax_rate = 0.13
          elsif customer_location == "Quebec" then tax_rate = 0.1475
          elsif customer_location == "Saskatchewan" then tax_rate = 0.1
          end
        elsif customer_location != merchant_location
          if customer_location == "Alberta" then tax_rate = 0.05
          elsif customer_location == "British Columbia" then tax_rate = 0.05
          elsif customer_location == "Manitoba" then tax_rate = 0.05
          elsif customer_location == "Quebec" then tax_rate = 0.05
          elsif customer_location == "Saskatchewan" then tax_rate = 0.05
          end
        elsif customer_country != "Canada" then tax_rate = 0
        end
        tax_rate
      end
end
