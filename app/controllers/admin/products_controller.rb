class Admin::ProductsController < ApplicationController
  #Merchant backend
  layout "store_merchant_layout"
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :verify_is_merchant

  require 'paperclip'


  def index
     if params[:query]
      @products = current_user.products.order("updated_at DESC").search(params[:query]).paginate(:page => params[:page],:per_page => 5)
     else
      @products = current_user.products.order("updated_at DESC").paginate(:page => params[:page],:per_page => 5)
    end

  end
  def clothing
    if params[:query]
    @clothing = current_user.products.clothing.order("updated_at DESC").search(params[:query]).paginate(:page => params[:page],:per_page => 5)
    else
    @clothing = current_user.products.clothing.order("updated_at DESC").paginate(:page => params[:page],:per_page => 5)
    end
  end
  def hard_goods
    if params[:query]
    @hard_goods = current_user.products.hard_goods.order("updated_at DESC").search(params[:query]).paginate(:page => params[:page],:per_page => 5)
    else
    @hard_goods = current_user.products.hard_goods.order("updated_at DESC").paginate(:page => params[:page],:per_page => 5)
    end
  end
  def waxing
    if params[:query]
    @waxing = current_user.products.waxing.order("updated_at DESC").search(params[:query]).paginate(:page => params[:page],:per_page => 5)
    else
    @waxing = current_user.products.waxing.order("updated_at DESC").paginate(:page => params[:page],:per_page => 5)
    end
  end
  def accessories
    if params[:query]
    @accessories = current_user.products.accessories.order("updated_at DESC").search(params[:query]).paginate(:page => params[:page],:per_page => 5)
    else
    @accessories = current_user.products.accessories.order("updated_at DESC").paginate(:page => params[:page],:per_page => 5)
    end
  end

  def show
    @product = Product.find(params[:id])

  end

  def new
    @product = Product.new
    respond_to do |format|
      format.js
      format.html
    end

  end

  def edit
    @product = Product.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @product = Product.create(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_products_url, notice: 'Product was successfully added.' }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    @product = Product.find(params[:id])
    respond_to do |format|
    if @product.update(product_params)
        format.html {redirect_to admin_products_url}
        format.json {respond_with_bip(@product) }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
     end
   end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_url, notice: 'Product was successfully deleted.' }
      format.json { head :no_content }
    end
  end




  private
      def set_product
        @products = Product.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:id, :name, :description, :status, :user_id, :price, :currency, :created_at, :updated_at, :photo, :size_details, :product_category, :product_subcategory, :shipping_charge, :product_return_policy, units_attributes: [:id, :product_id, :size, :quantity, :quantity_sold, :colour, :_destroy], :order_ids => [], productfotos_attributes: [:id, :product_id, :foto, :_destroy])
      end

      def verify_is_merchant
        (current_user.nil?) ? redirect_to(shop_path) : (redirect_to(shop_path) unless current_user.merchant?)
      end
end
