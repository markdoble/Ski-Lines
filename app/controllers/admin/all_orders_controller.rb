class Admin::AllOrdersController < ApplicationController
  layout "store_merchant_layout"
  before_action :authenticate_user!


  def index
    verify_is_admin
    @order = Order.all.order("created_at DESC")
  end

  def show
    verify_is_admin
    @order = Order.find(params[:id])
  end

  def merchants
    verify_is_admin
    @merchants = User.merchants
  end

  def rep
    verify_is_admin
    @rep = current_user
  end

  private
    def verify_is_admin
      (current_user.nil?) ? redirect_to(shop_path) : (redirect_to(shop_path) unless current_user.admin?)
    end

end
