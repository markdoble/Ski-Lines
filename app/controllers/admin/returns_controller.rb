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
    @return = Return.find(params[:id])

  end

  def update
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
    params.require(:return).permit(:order_units_id, :qty_returned, :reason, :order_id)
  end

end
