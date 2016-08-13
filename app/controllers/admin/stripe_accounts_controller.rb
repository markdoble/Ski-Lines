class Admin::StripeAccountsController < ApplicationController
  layout "store_merchant_layout"
  before_action :authenticate_user!
  before_filter :verify_is_merchant


  def account
    if current_user.stripe_account_id.blank?
      redirect_to admin_stripe_accounts_new_stripe_account_path
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
      account = Stripe::Account.retrieve(current_user.stripe_account_id)
      account = [{
        :legal_entity => [
          :type => params[:type]
        ],
      }]
      if params[:tos] == true
        account.tos_acceptance = [{
            :date => Date.current,
            :ip => request.remote_ip
        }]
      end
    rescue


    end
  end

  def verify_account
    Stripe.api_key = ENV['PLATFORM_SECRET_KEY']
    begin
      user_account = current_user.stripe_account_id
      account = Stripe::Account.retrieve(user_account)
      account = [{
        :legal_entity => [
          :dob => [
            :day => params[:dob_day],
            :month => params[:dob_month],
            :year => params[:dob_year]
          ],
          :first_name => params[:first_name],
          :last_name => params[:last_name]
        ]
      }]
    rescue
      flash[:error] = "There was an error updating your account."
      redirect_to admin_stripe_accounts_new_stripe_account_path
    end
  end

  def new_stripe_account
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
