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
      @account_first_name = account.legal_entity.first_name
      @account_last_name = account.legal_entity.last_name
      @dob_day = account.legal_entity.dob.day
      @dob_month = account.legal_entity.dob.month
      @dob_year = account.legal_entity.dob.year
    rescue
      flash[:error] = "Could not connect to Stripe"
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

      account.legal_entity.type = params[:type]
      if params[:tos]
        account.tos_acceptance.date = Time.now.to_i
        account.tos_acceptance.ip = request.remote_ip
      end
      account.save
      redirect_to admin_account_path
      flash[:notice] = "Successfully update!"
    rescue Stripe::StripeError => e
      redirect_to admin_account_path
      flash[:error] = e.message
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

end
