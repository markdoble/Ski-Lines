class Admin::StripeAccountsController < ApplicationController
  layout "store_merchant_layout"
  before_action :authenticate_user!
  before_filter :verify_is_merchant

  def account
    @merchant = current_user
  end

  def create_stripe_account
    # use this action to create account and add the account id to the current_user's account 
  end



  private
    def verify_is_merchant
      (current_user.nil?) ? redirect_to(shop_path) : (redirect_to(shop_path) unless current_user.merchant?)
    end

end
