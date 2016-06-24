class Admin::OrdersController < ApplicationController
  layout "store_merchant_layout"
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  def index
   verify_is_admin
  end

  def merchants
    verify_is_admin
    @merchants = User.merchants
  end


  def all_orders
    verify_is_admin
    @order = Order.all.order("created_at DESC")
  end

  def myperformance
    verify_is_merchant
    @orders = Order.all
    @order = current_user.orders.order("created_at DESC")
  end

  def show
    verify_is_admin
    verify_is_merchant
      @order = Order.find(params[:id])
      if @order.transaction_id
        @transaction = Braintree::Transaction.find(@order.transaction_id)
      end
  end

  def update
    @order = Order.find(params[:id])
    respond_to do |format|
    if @order.update(order_params)
        format.html {redirect_to admin_orders_myperformance_url}
        format.json {respond_with_bip(@order) }
      else
     redirect_to admin_orders_myperformance_url
     end
   end
  end



  private
    def set_order
      @orders = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:street_address, :prov_state, :country, :city, :postal_zip, :cust_first_name, :cust_last_name, :cust_email, :cust_phone, :status, :marketing_optout, :amount, :sales_tax, :shipping, :merchant_orders_attributes => [:id, :user_id, :order_id, :order_status, :product_id, :delivery_method, :customer_comments], :product_ids => [], :order_units_attributes => [:id, :unit_id, :order_id, :quantity])
    end

    def verify_is_admin
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(admin_products_path) unless current_user.admin?)
    end
    def verify_is_merchant
        (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.merchant?)
    end

end
