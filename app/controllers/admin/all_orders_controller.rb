class Admin::AllOrdersController < ApplicationController
  layout "store_merchant_layout"
  before_action :authenticate_user!
  before_action :verify_is_admin


  def index
    @order = Order.all.order("created_at DESC")
  end

  def show
    @order = Order.find(params[:id])
    if @order.transaction_id
      @transaction = Braintree::Transaction.find(@order.transaction_id)
    end
  end

  def merchants
    @merchants = User.merchants
  end

  private
    def verify_is_admin
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(admin_products_path) unless current_user.admin?)
    end

end
