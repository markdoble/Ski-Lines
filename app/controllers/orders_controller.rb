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
    order_session_present?
  end

  def create_customer_details
    @order = Order.find(params[:id])
    respond_to do |format|
      if @order.update_attributes(order_params)
        # update attributes with sales_tax, amount, and shipping
        update_order_units_attributes(@order)
        update_order_attributes(@order)
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
    order_session_present?
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
        params.require(:order).permit(
          :street_address,
          :prov_state,
          :country, :city,
          :postal_zip,
          :cust_first_name,
          :cust_last_name,
          :cust_email,
          :cust_phone,
          :status,
          :marketing_optout,
          :amount,
          :sales_tax,
          :shipping,
          :success,
          :merchant_orders_attributes => [
              :id,
              :user_id,
              :order_id,
              :product_id,
              :order_status,
              :delivery_method,
              :customer_comments
              ],
          :product_ids => [],
          :order_units_attributes => [
              :id,
              :unit_id,
              :order_id,
              :quantity
              ]
        )
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

      def order_session_present?
        if session[:order_session]
          @order_session = session[:order_session]
        else
          @order_session = nil
          redirect_to :action => :index
        end
      end

      def update_order_units_attributes(order)
        order.order_units.where.not(quantity: 0).each do |f|
          shipping_fee = f.unit.product.shipping_charge
          f.update_attributes(
            :sales_tax_charged => tax_jar_sales_tax_request(f),
            :shipping_charged => f.unit.product.shipping_charge
          )
        end
      end

      def update_order_attributes(order)
        order.update_attributes(
          :sales_tax => calculate_sales_tax(@order),
          :shipping => calculate_shipping(@order),
          :amount => calculate_total_amount(@order)
        )
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

      def tax_jar_sales_tax_request(f)
        order_unit = f
        require 'taxjar'
        client = Taxjar::Client.new(api_key: ENV['TAXJAR_APIKEY'])
        to_country = order_unit.order.country
        to_state = order_unit.order.prov_state
        from_country = order_unit.unit.product.user.country
        from_state = order_unit.unit.product.user.state_prov
        taxjar_result = client.tax_for_order({
            :to_country => santize_country(to_country),
            :to_city => order_unit.order.city,
            :to_state => sanitize_prov_state(to_state),
            :to_zip => order_unit.order.postal_zip,
            :from_country => santize_country(from_country),
            :from_city => order_unit.unit.product.user.city,
            :from_state => sanitize_prov_state(from_state),
            :from_zip => order_unit.unit.product.user.zip_postal,
            :amount => order_unit.unit.product.price,
            :shipping => order_unit.unit.product.shipping_charge
        })
        taxjar_result.amount_to_collect
      end

      def calculate_sales_tax(order)
        sales_tax_total = 0
        order.order_units.where.not(quantity: 0).each do |p|
          sales_tax_total += (p.sales_tax_charged*p.quantity)
        end
        sales_tax_total
      end

      def santize_country(country)
        case country
        when 'United States of America'
          'US'
        when 'Canada'
          'CA'
        end
      end

      def sanitize_prov_state(prov_state)
        case prov_state
        when 'Alberta'
          'AB'
        when 'British Columbia'
          'BC'
        when 'Manitoba'
          'MB'
        when 'New Brunswick'
          'NB'
        when 'Newfoundland and Labrador'
          'NL'
        when 'Northwest Territories'
          'NT'
        when 'Nova Scotia'
          'NS'
        when 'Nunavut'
          'NU'
        when 'Ontario'
          'ON'
        when 'Prince Edward Island'
          'PE'
        when 'Quebec'
          'QC'
        when 'Saskatchewan'
          'SK'
        when 'Yukon'
          'YT'
        when 'Alabama'
          'AL'
        when 'Alaska'
          'AK'
        when 'Arizona'
          'AZ'
        when 'Arkansas'
          'AR'
        when 'California'
          'CA'
        when 'Colorado'
          'CO'
        when 'Connecticut'
          'CT'
        when 'Delaware'
          'DE'
        when 'Florida'
          'FL'
        when 'Georgia'
          'GA'
        when 'Hawaii'
          'HI'
        when 'Idaho'
          'ID'
        when 'Illinois'
          'IL'
        when 'Indiana'
          'IN'
        when 'Iowa'
          'IA'
        when 'Kansas'
          'KS'
        when 'Kentucky'
          'KY'
        when 'Louisiana'
          'LA'
        when 'Maine'
          'ME'
        when 'Maryland'
          'MD'
        when 'Massachusetts'
          'MA'
        when 'Michigan'
          'MI'
        when 'Minnesota'
          'MN'
        when 'Mississippi'
          'MS'
        when 'Missouri'
          'MO'
        when 'Montana'
          'MT'
        when 'Nebraska'
          'NE'
        when 'Nevada'
          'NV'
        when 'New Hampshire'
          'NH'
        when 'New Jersey'
          'NJ'
        when 'New Mexico'
          'NM'
        when 'New York'
          'NY'
        when 'North Carolina'
          'NC'
        when 'North Dakota'
          'ND'
        when 'Ohio'
          'OH'
        when 'Oklahoma'
          'OK'
        when 'Oregon'
          'OR'
        when 'Pennsylvania'
          'PA'
        when 'Rhode Island'
          'RI'
        when 'South Carolina'
          'SC'
        when 'South Dakota'
          'SD'
        when 'Tennessee'
          'TN'
        when 'Texas'
          'TX'
        when 'Utah'
          'UT'
        when 'Vermont'
          'VT'
        when 'Virginia'
          'VA'
        when 'Washington'
          'WA'
        when 'Washington, D.C.'
          'DC'
        when 'West Virginia'
          'WV'
        when 'Wisconsin'
          'WI'
        when 'Wyoming'
          'WY'
        else
        end
      end
end
