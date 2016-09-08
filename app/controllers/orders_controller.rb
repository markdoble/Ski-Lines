class OrdersController < ApplicationController
  layout "order_layout"
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_filter :find_or_create_cart, only: [:index, :edit, :create, :update, :payment_form, :customer_details_form, :confirmation, :create_customer_details]

  # for pre-launch only:
  before_action :authenticate_user!

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
    redirect_to shop_path
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
    
    if @cart.empty?
      @nofooter = true
    end
  end

  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save(validate: false) && @order.order_units.any?{|e| e.quantity != 0}
        create_order_session
        @order.update_attribute(:success, false)
        format.html { redirect_to orders_customer_details_form_path(@order) }
        format.json { render json: @order }
      else
        @order.update_attribute(:success, false)
        create_order_session
        flash[:error] = "You must make a selection before continuing."
        format.html { redirect_to cart_path }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find_by_id(session[:order_session])
    respond_to do |format|
      if @order.update(order_params) && @order.order_units.any?{|e| e.quantity != 0}
        @order.update_attribute(:success, false)
        format.html { redirect_to orders_customer_details_form_path(@order) }
        format.json { render json: @order }
      else
        @order.update_attribute(:success, false)
        flash.now[:error] = "You must make a selection before continuing."
        format.html { render action: 'index' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def customer_details_form
    @order = Order.find_by_id(session[:order_session])
    @prevent_change_to_country = true
    redirect_if_no_order_session_present
  end

  def create_customer_details
    @order = Order.find(params[:id])
    respond_to do |format|
      # update order_unit attributes with sales_tax, amount, and shipping FIRST,
      # before you can update order attributes
      if @order.update_attributes(order_params)
        if update_order_units_attributes(@order)
          if check_permitted_destinations(@order)
            format.html { redirect_to orders_payment_form_path(@order) }
            format.json { render json: @order }
          else
            format.html { redirect_to cart_path }
            flash[:error] = "One or more products cannot be shipped to your address. Please review your selections before continuing."
            format.json { render json: @order.errors, status: :unprocessable_entity }
          end
        else
          format.html { render action: 'customer_details_form' }
          flash[:error] = "Please make sure your address is correct before continuing!"
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      else
        flash[:error] = "Please make sure your address is correct before continuing!"
        format.html { render action: 'customer_details_form' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end

    end
  end

  def payment_form
    @order = Order.find_by_id(session[:order_session])
    @prevent_change_to_country = true
    redirect_if_no_order_session_present
  end

  def create_payment
    @order = Order.find_by_id(session[:order_session])
    # receive token from client side Stripe
    token = params[:stripeToken]
    begin
      # create customer to be used in charge in order_units loop below
      customer = Stripe::Customer.create(
        :card => token,
        :email => @order.cust_email
      )
      # authorize payment for each unit before capturing payments
      # initialize empty array of charges
      array_of_charges = []
      # loop through each order_unit, and charge each individually
      @order.order_units.where.not(quantity: 0).each do |f|
        # calculate amount in cents
        amount_times_one_hundred = (f.sub_total+f.sales_tax_charged+f.shipping_charged)*100
        # remove decimal and everything after the decimal to calculate amount_in_cents
        amount_in_cents = amount_times_one_hundred.to_s.split(".")[0].to_i
        # calculate amount not including tax for calculation of application_fee
        amount_less_tax_times_one_hundred = (f.sub_total+f.shipping_charged)*100
        # remove decimal and everything after
        amount_less_tax_in_cents = amount_less_tax_times_one_hundred.to_s.split(".")[0].to_i
        # calculate platform "commission" fee
        platform_fee = amount_less_tax_in_cents*0.0645
        # calculate fee for payment processing
        payment_processing_fee = amount_in_cents*0.034
        # summ the fees to calculate application_fee sent to Stripe
        application_fee = (platform_fee+payment_processing_fee).to_s.split(".")[0].to_i
        # get currency from order_units
        currency = f.currency
        # add description to appear con credit card statement
        description = "Ski-Lines" + "-" + f.unit.product.name
        # merchant stripe account id to charge to
        merchant_stripe_account = f.unit.product.user.stripe_account_id
        # create array of charges to for later capture.
        # Need to know all charges will pass first before capturing them
        array_of_charges << Stripe::Charge.create(
          :amount => amount_in_cents,
          :currency => currency,
          :customer => customer.id,
          :description => description,
          :capture => false,
          :destination => merchant_stripe_account,
          :application_fee => application_fee
        )
      end
      # capture each charge if all authorized. if even one does not authorize, refund all
      array_of_charges.each do |f|
        Stripe::Charge.retrieve(f.id).capture
      end
      # update the transaction_id on order with Stripe customer id
      @order.update_attributes(transaction_id: customer.id)
      # create successful order session
      create_order_confirmation_session
      # update the success attribute on order to true, indicating successful order complete
      @order.update_attribute(:success, true)
      # update the inventory refective of order quantities
      update_inventory(@order)
      # send order emails
      order_emails(@order)
      # delete cart session
      session.delete(:cart)
      # redirect to successful order confirmation page
      redirect_to orders_confirmation_path(@order)
    rescue Stripe::CardError => e
      # The card/charge has been declined
      @order.update_attribute(:success, false)
      # redirect to the payment form page if charge fails
      redirect_to orders_payment_form_path(@order)
      # flash the payment error message
      flash[:error] = e.message
    end
  end

  def confirmation
    @order = Order.find_by_id(session[:order_confirmation_session])
    @prevent_change_to_country = true
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
        # Removed amount, sales_tax, and shipping
        params.require(:order).permit(
          :street_address,
          :prov_state,
          :country, :city,
          :postal_zip,
          :cust_first_name,
          :cust_last_name,
          :cust_email,
          :cust_email_confirmation,
          :cust_phone,
          :status,
          :marketing_optout,
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

      def check_permitted_destinations(order)
        order.order_units.each do |m|
          country = m.order.country
          sanitized_country = santize_country(country)
          return false unless m.unit.product.user.default_permitted_destinations.any?{ |a| a.country.alpha_2_code == sanitized_country}
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

      def redirect_if_no_order_session_present
        if session[:order_session]
          @order_session = session[:order_session]
        else
          @order_session = nil
          redirect_to :action => :index
        end
      end

      def update_order_units_attributes(order)
        order.order_units.where.not(quantity: 0).each do |f|
          begin
            # if customer and merchant are in the same country
            if f.order.country == f.unit.product.user.country
              # apply the domestic shipping fee
              shipping_fee_per_unit = f.unit.product.currency_domestic_shipping(session[:site_country])
            else
              # otherwise apply the foreign shipping fee
              shipping_fee_per_unit = f.unit.product.currency_foreign_shipping(session[:site_country])
            end
            # determine is customer is picking up product in store
            delivery_method = f.order.merchant_orders.find_by(product_id: f.unit.product.id).delivery_method
            case delivery_method
            when "Standard Shipping"
              # when customer requests shipping
              total_shipping_fee = shipping_fee_per_unit*f.quantity
              # calculate sales tax with shipping
              sales_tax_charged = tax_jar_sales_tax_request_for_delivery(f, shipping_fee_per_unit)
            else
              # when customer is picking up product in store
              total_shipping_fee = 0
              # calculate sales tax without shipping
              sales_tax_charged = tax_jar_sales_tax_request_for_in_store_pickup(f)
            end
          rescue => e
            return false
          else
            # shipping fee that is saved accounts for quantity.
            order_unit_amount_less_tax_and_shipping = f.unit.product.currency_price(session[:site_country])*f.quantity
            # update order_unit attributes
            f.update_attributes(
              :sales_tax_charged => sales_tax_charged,
              :shipping_charged => total_shipping_fee,
              :sub_total => order_unit_amount_less_tax_and_shipping,
              # save the currency that is used for order.
              :currency => currency_session(session[:site_country])
            )
          end
        end
        update_order_attributes(order)
      end

      def update_order_attributes(order)
        # update order with tax, shipping, and total
        # save the currency that is used for order, using same method as above.
        order.update_attributes(
          :sales_tax => calculate_sales_tax(@order),
          :shipping => calculate_shipping(@order),
          :amount => calculate_total_amount(@order),
          :currency => currency_session(session[:site_country])
        )
      end

      def calculate_total_amount(order)
        total = 0
        order.order_units.where.not(quantity: 0).each do |p|
          total += (p.sub_total)+p.shipping_charged+p.sales_tax_charged
        end
        total
      end

      def calculate_shipping(order)
        shipping_total = 0
        order.order_units.where.not(quantity: 0).each do |p|
          shipping_total += p.shipping_charged
        end
        shipping_total
      end

      def calculate_sales_tax(order)
        sales_tax_total = 0
        order.order_units.where.not(quantity: 0).each do |p|
          sales_tax_total += p.sales_tax_charged
        end
        sales_tax_total
      end

      def tax_jar_sales_tax_request_for_delivery(f, shipping_fee_per_unit)
        require 'taxjar'
        client = Taxjar::Client.new(api_key: ENV['TAXJAR_APIKEY'])
        to_country = f.order.country
        to_state = f.order.prov_state
        to_city = f.order.city
        to_zip = f.order.postal_zip
        from_country = f.unit.product.user.country
        from_state = f.unit.product.user.state_prov
        from_city = f.unit.product.user.city
        from_zip = f.unit.product.user.zip_postal
        shipping = (shipping_fee_per_unit*f.quantity)
        amount = f.unit.product.currency_price(session[:site_country])*f.quantity
        taxjar_result = client.tax_for_order({
            :to_country => santize_country(to_country),
            :to_city => to_city,
            :to_state => sanitize_prov_state(to_state),
            :to_zip => to_zip,
            :from_country => santize_country(from_country),
            :from_city => from_city,
            :from_state => sanitize_prov_state(from_state),
            :from_zip => from_zip,
            :amount => amount,
            :shipping => shipping
        })
        taxjar_result.amount_to_collect
      end

      def tax_jar_sales_tax_request_for_in_store_pickup(f)
        require 'taxjar'
        client = Taxjar::Client.new(api_key: ENV['TAXJAR_APIKEY'])
        # set variables for TaxJar API
        # this method is for in store pickup items, therefore to_ equals from_
        from_country = f.unit.product.user.country
        from_state = f.unit.product.user.state_prov
        from_city = f.unit.product.user.city
        from_zip = f.unit.product.user.zip_postal
        to_country = from_country
        to_state = from_state
        to_city = from_city
        to_zip = from_zip
        amount = f.unit.product.currency_price(session[:site_country])*f.quantity
        taxjar_result = client.tax_for_order({
            :to_country => santize_country(to_country),
            :to_city => to_city,
            :to_state => sanitize_prov_state(to_state),
            :to_zip => to_zip,
            :from_country => santize_country(from_country),
            :from_city => to_city,
            :from_state => sanitize_prov_state(from_state),
            :from_zip => to_zip,
            :amount => amount,
            :shipping => 0
        })
        taxjar_result.amount_to_collect
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
