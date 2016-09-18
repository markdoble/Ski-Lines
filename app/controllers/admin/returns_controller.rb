class Admin::ReturnsController < ApplicationController
  layout "store_merchant_layout"
  before_action :set_return, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @returns = Return.all
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
      if @return.save && update_default_attributes(@return)
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
      :suggested_sub_total,
      :suggested_sales_tax,
      :suggested_shipping_charge,
      :default_sub_total,
      :default_sales_tax,
      :default_shipping_charge)
  end

  def update_default_attributes(return_request)
    order_unit = OrderUnits.find_by_id(return_request.order_units_id)
    quantity = return_request.qty_returned
    product_price_charged = order_unit.sub_total/order_unit.quantity
    sub_total = product_price_charged*quantity
    sales_tax = sub_total*order_unit.sales_tax_rate
    shipping = 0
    return_request.update_attributes(
      default_sub_total: sub_total,
      default_sales_tax: sales_tax,
      default_shipping_charge: shipping
    )
  end

end
