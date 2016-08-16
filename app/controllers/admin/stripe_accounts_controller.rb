class Admin::StripeAccountsController < ApplicationController
  layout "store_merchant_layout"
  before_action :authenticate_user!
  before_filter :verify_is_merchant


  def account
    if current_user.stripe_account_id.blank?
      redirect_to admin_stripe_accounts_new_stripe_account_path
    end
    begin
      Stripe.api_key = ENV['PLATFORM_SECRET_KEY']
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
      @account_status = account.transfers_enabled unless account.transfers_enabled.nil?
      @business_tax_id = account.legal_entity.business_tax_id unless account.legal_entity.business_tax_id.nil?
      @ssn_last_4 = account.legal_entity.ssn_last_4 unless account.legal_entity.ssn_last_4.nil?
      @personal_id_number = account.legal_entity.personal_id_number unless account.legal_entity.personal_id_number.nil?

      @fields_needed = account.verification.fields_needed unless account.verification.fields_needed.nil?
      
    rescue Stripe::StripeError => e
      flash.now[:error] = e.message
    end
  end

  def update_banking
    Stripe.api_key = ENV['PLATFORM_SECRET_KEY']
    token = params[:stripeToken]
    # update external_account hash

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
      flash[:notice] = "Successfully update!"
    rescue Stripe::StripeError => e
      redirect_to admin_account_path
      flash.now[:error] = e.message
    end
  end

  def verify_account
    begin
      user_account = current_user.stripe_account_id
      Stripe.api_key = ENV['PLATFORM_SECRET_KEY']
      account = Stripe::Account.retrieve(user_account)

      account.legal_entity.first_name = params[:first_name]
      account.legal_entity.last_name = params[:last_name]
      account.legal_entity.dob.day = params[:dob_day]
      account.legal_entity.dob.month = params[:dob_month]
      account.legal_entity.dob.year = params[:dob_year]

      account.save
      redirect_to admin_account_path
      flash[:notice] = "Successfully update!"
    rescue Stripe::StripeError => e
      redirect_to admin_account_path
      flash[:error] = e.message
    end
  end

  def new_stripe_account
  end

  def edit_stripe_account

  end

  def create_account
    # use this action to create account and add the account id to the current_user's account
    user = User.find(current_user.id)
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
      redirect_to admin_account_path
    rescue
      flash[:error] = "There was a problem creating your account. Try again, but if the problem persists, contact your Ski-Lines representative."
      redirect_to admin_stripe_accounts_new_stripe_account_path
    end
  end

  private
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
