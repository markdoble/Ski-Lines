class Admin::ReturnsController < ApplicationController
  layout "store_merchant_layout"
  before_action :set_return, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :verify_is_merchant

  def index
    @user_returns = Return.where(user_id: current_user.id).order("created_at DESC")
  end

  def new
    @order = Order.find_by_id(params[:order_id])
    @order_unit = OrderUnits.find_by_id(params[:order_unit_id])
    @return = Return.new
  end

  def show
  end

  def create
    @return = Return.create(return_params)
    respond_to do |format|
      if @return.save && update_default_attributes(@return, current_user.id)
        format.html { redirect_to admin_orders_url, notice: 'Your refund request has been submitted.' }
      else
        format.html { render :new }
        format.json { render json: @return.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @return.update(return_params)
        format.html {redirect_to admin_orders_url, notice: "Your refund request has been updated."}
        format.json {render json: @return }
      else
      redirect_to admin_products_url
      end
    end
  end

  def edit
  end

  def delete
  end

private

  def set_return
    @return = Return.find(params[:id])
  end

  def return_params
    params.require(:return).permit(
      :order_units_id,
      :qty_returned,
      :reason,
      :order_id,
      :refund_complete,
      :suggested_sub_total,
      :suggested_sales_tax,
      :suggested_shipping_charge,
      :default_sub_total,
      :default_sales_tax,
      :default_shipping_charge)
  end

  def update_default_attributes(return_request, user_id)
    order_unit = OrderUnits.find_by_id(return_request.order_units_id)
    quantity = return_request.qty_returned
    product_price_charged = order_unit.sub_total/order_unit.quantity
    sub_total = product_price_charged*quantity
    sales_tax = sub_total*order_unit.sales_tax_rate
    shipping = 0
    return_request.update_attributes(
      default_sub_total: sub_total,
      default_sales_tax: sales_tax,
      default_shipping_charge: shipping,
      user_id: user_id
    )
    if return_request.suggested_sub_total.nil?
      return_request.update_attribute(:suggested_sub_total, 0.00)
    end
    if return_request.suggested_sales_tax.nil?
      return_request.update_attribute(:suggested_sales_tax, 0.00)
    end
    if return_request.suggested_shipping_charge.nil?
      return_request.update_attribute(:suggested_shipping_charge, 0.00)
    end
    if return_request.actual_sub_total_refunded.nil?
      return_request.update_attribute(:actual_sub_total_refunded, 0.00)
    end
    if return_request.actual_sales_tax_refunded.nil?
      return_request.update_attribute(:actual_sales_tax_refunded, 0.00)
    end
    if return_request.actual_shipping_charge_refunded.nil?
      return_request.update_attribute(:actual_shipping_charge_refunded, 0.00)
    end
  end

  # Verify if the current user is logged in and is a merchant
  def verify_is_merchant
    (current_user.nil?) ? redirect_to(shop_path) : (redirect_to(shop_path) unless current_user.merchant?)
  end

end
