class Admin::SupportsController < ApplicationController
  layout "store_merchant_layout"
  before_action :authenticate_user!
  before_action :verify_is_merchant

  def index
  end

  private


  # Verify if the current user is logged in and is a merchant
  def verify_is_merchant
    (current_user.nil?) ? redirect_to(shop_path) : (redirect_to(shop_path) unless current_user.merchant?)
  end


end
