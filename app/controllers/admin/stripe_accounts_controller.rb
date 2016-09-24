class Admin::StripeAccountsController < ApplicationController
  layout "store_merchant_layout"
  before_action :authenticate_user!
  before_filter :verify_is_merchant

  def account
    if current_user.stripe_account_id.blank?
      redirect_to admin_stripe_accounts_new_stripe_account_path
    else
      Stripe.api_key = ENV['PLATFORM_SECRET_KEY']
      begin
        user_account = current_user.stripe_account_id.to_s
        account = Stripe::Account.retrieve(user_account)
        @business_name = account.legal_entity.business_name unless account.legal_entity.business_name.nil?
        @entity_type = account.legal_entity.type unless account.legal_entity.type.nil?
        @account_first_name = account.legal_entity.first_name unless account.legal_entity.first_name.nil?
        @account_last_name = account.legal_entity.last_name unless account.legal_entity.last_name.nil?
        @dob_day = account.legal_entity.dob.day unless account.legal_entity.dob.day.nil?
        @dob_month = account.legal_entity.dob.month unless account.legal_entity.dob.month.nil?
        @dob_year = account.legal_entity.dob.year unless account.legal_entity.dob.year.nil?
        @address = account.legal_entity.address.line1 unless account.legal_entity.address.line1.nil?
        @city = account.legal_entity.address.city unless account.legal_entity.address.city.nil?
        @country = account.legal_entity.address.country unless account.legal_entity.address.country.nil?
        @state = account.legal_entity.address.state unless account.legal_entity.address.state.nil?
        @zip_postal = account.legal_entity.address.postal_code unless account.legal_entity.address.postal_code.nil?
        @tos_acceptance = account.tos_acceptance.date unless account.tos_acceptance.date.nil?

        # will be true or false, depending on if tax id submitted
        @business_tax_id_provided = account.legal_entity.business_tax_id_provided unless account.legal_entity.business_tax_id_provided.nil?
        # for U.S. accounts only, lest 4 digist of SSN.
        if @country == 'us'
          @ssn_last_4 = account.legal_entity.ssn_last_4_provided unless account.legal_entity.ssn_last_4_provided.nil?
        end
        # will be false if personal id number hasn't been provided. SIN for Canada and SSN for U.S.
        @personal_id_number_provided = account.legal_entity.personal_id_number_provided unless account.legal_entity.personal_id_number_provided.nil?

        @transfer_schedule_delay = account.transfer_schedule.delay_days unless account.transfer_schedule.delay_days.nil?
        @transfer_schedule_interval = account.transfer_schedule.interval unless account.transfer_schedule.interval.nil?
        # list of fields needed to require identity
        @fields_needed = account.verification.fields_needed
        # account status
        @charges_enabled = account.charges_enabled unless account.charges_enabled.nil?
        # whether automatic transfers are enable for this account.
        @transfers_enabled = account.transfers_enabled unless account.transfers_enabled.nil?
        # identity verification status, can be unverified, pending, or verified.
        @verification_status = account.legal_entity.verification.status

        @external_accounts = account.external_accounts.all(:object => "bank_account") unless account.external_accounts.nil?

      rescue Stripe::StripeError => e
        flash[:error] = e.message
      end
    end
  end

  def update_banking
    Stripe.api_key = ENV['PLATFORM_SECRET_KEY']
    begin
      token = params[:stripeToken]
      user_account = current_user.stripe_account_id.to_s
      account = Stripe::Account.retrieve(user_account)
      account.external_accounts.create({:external_account => token})
      redirect_to admin_account_path
      flash[:notice] = "You have successfully added a bank account!"
    rescue Stripe::StripeError => e
      redirect_to admin_account_path
      flash[:error] = e.message
    end
  end

  def update_company_details
    Stripe.api_key = ENV['PLATFORM_SECRET_KEY']
    begin
      account_user = current_user.stripe_account_id
      account = Stripe::Account.retrieve(account_user)
      account.legal_entity.business_name = params[:business_name]
      account.legal_entity.type = params[:type]
      account.legal_entity.business_tax_id = params[:business_number]
      account.legal_entity.address.line1 = params[:address]
      account.legal_entity.address.city = params[:city]
      account.legal_entity.address.state = params[:state]
      account.legal_entity.address.country = params[:country]
      account.legal_entity.address.postal_code = params[:zip_postal]
      if params[:tos]
        account.tos_acceptance.date = Time.now.to_i
        account.tos_acceptance.ip = request.remote_ip
      end
      account.save
      redirect_to admin_account_path
      flash[:notice] = "Successfully updated!"
    rescue Stripe::StripeError => e
      redirect_to admin_account_path
      flash[:error] = e.message
    end
  end

  def update_personal_id_number
    Stripe.api_key = ENV['PLATFORM_SECRET_KEY']
    begin
      user_account = current_user.stripe_account_id
      account = Stripe::Account.retrieve(user_account)
      account.legal_entity.personal_id_number = params[:stripeToken]
      account.save
      redirect_to admin_account_path
      flash[:notice] = "Successfully updated!"
    rescue Stripe::StripeError => e
      redirect_to admin_account_path
      flash[:error] = e.message
    end
  end

  def verify_account
    Stripe.api_key = ENV['PLATFORM_SECRET_KEY']
    begin
      user_account = current_user.stripe_account_id
      account = Stripe::Account.retrieve(user_account)
      account.legal_entity.first_name = params[:first_name] unless params[:first_name].blank?
      account.legal_entity.last_name = params[:last_name] unless params[:last_name].blank?
      account.legal_entity.dob.day = params[:dob_day] unless params[:dob_day].blank?
      account.legal_entity.dob.month = params[:dob_month] unless params[:dob_month].blank?
      account.legal_entity.dob.year = params[:dob_year] unless params[:dob_year].blank?
      account.save
      redirect_to admin_account_path
      flash[:notice] = "Successfully updated!"
    rescue Stripe::StripeError => e
      redirect_to admin_account_path
      flash[:error] = e.message
    end
  end

  def new_stripe_account
  end

  def create_account
    Stripe.api_key = ENV['PLATFORM_SECRET_KEY']
    # use this action to create account and add the account id to the current_user's account
    user = User.find(current_user.id)
    if  params[:tos]
      begin
        country = santize_country(user.country)
        currency = select_currency(user.country)
        account = Stripe::Account.create(
          {
            :country => country,
            :managed => true,
            :default_currency => currency,
          }
        )
        user.update_attribute(:stripe_account_id, account.id)
        if terms_acceptance = params[:tos]
          update_stripe_attributes(user)
          redirect_to admin_products_path
          flash[:notice] = "Congratulations! You have successfully created your Merchant Account!"
        else
          redirect_to admin_stripe_accounts_new_stripe_account_path
          flash[:error] = "You must agree to the terms of service before continuing."
        end
      rescue Stripe::StripeError => e
        redirect_to admin_stripe_accounts_new_stripe_account_path
        flash[:error] = e.message
      end
    else
      redirect_to admin_stripe_accounts_new_stripe_account_path
      flash[:error] = "You must accept the terms and conditions before continuing."
    end
  end

  private
    def update_stripe_attributes(user)
      user_account = user.stripe_account_id.to_s
      account = Stripe::Account.retrieve(user_account)
      account.legal_entity.type = "company"
      account.legal_entity.business_name = user.merchant_name.to_s unless user.merchant_name.blank?
      account.legal_entity.first_name = user.contact_first_name.to_s unless user.contact_first_name.blank?
      account.legal_entity.last_name = user.contact_last_name.to_s unless user.contact_last_name.blank?
      account.legal_entity.address.line1 = user.street_address.to_s unless user.street_address.blank?
      account.legal_entity.address.city = user.city.to_s unless user.city.blank?
      country = santize_country(user.country) unless user.country.blank?
      account.legal_entity.address.country = country unless user.country.blank?
      state = sanitize_prov_state(user.state_prov) unless user.state_prov.blank?
      account.legal_entity.address.state = state.to_s unless user.state_prov.blank?
      account.legal_entity.address.postal_code = user.zip_postal.to_s unless user.zip_postal.blank?
      account.tos_acceptance.date = Time.now.to_i
      account.tos_acceptance.ip = request.remote_ip
      account.save
    end

    def verify_is_merchant
      (current_user.nil?) ? redirect_to(shop_path) : (redirect_to(shop_path) unless current_user.merchant?)
    end

    def santize_country(country)
      case country
      when 'United States of America'
        'US'
      when 'Canada'
        'CA'
      end
    end

    def select_currency(country)
      case country
      when 'United States of America'
        'usd'
      when 'Canada'
        'cad'
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
