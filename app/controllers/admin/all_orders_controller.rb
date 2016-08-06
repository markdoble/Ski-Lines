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
    if @order.transaction_id
      @transaction = Braintree::Transaction.find(@order.transaction_id)
    end
  end

  def merchants
    verify_is_admin
    @merchants = User.merchants
  end

  def rep
    verify_is_rep
    @rep = current_user
  end

  private
    def verify_is_admin
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(admin_products_path) unless current_user.admin?)
    end

    def verify_is_rep
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(admin_products_path) unless current_user.merchant_rep?)
    end


end
