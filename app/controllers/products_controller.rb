class ProductsController < ApplicationController
  #store front
  layout "store_layout"
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :find_or_create_cart



  def index
    @hard_goods = Product.active_products.hard_goods.index_products
    @clothing = Product.clothing.active_products.index_products
    @waxing = Product.active_products.waxing.index_products
    @accessories = Product.active_products.accessories.index_products
  end

  def all_products
    @products = Product.active_products
    filtering_params(params).each do |key, value|
      @products = @products.active_products.public_send(key, value) if value.present?
    end
  end

  def hard_goods
    @hard_goods = Product.active_products.hard_goods
    filtering_params(params).each do |key, value|
      @hard_goods = @hard_goods.active_products.public_send(key, value) if value.present?
    end
  end

  def accessories
    @accessories = Product.active_products.accessories
    filtering_params(params).each do |key, value|
      @accessories = @accessories.active_products.public_send(key, value) if value.present?
    end
  end

  def clothing
    @clothing = Product.active_products.clothing
    filtering_params(params).each do |key, value|
      @clothing = @clothing.active_products.public_send(key, value) if value.present?
    end
  end

  def waxing
    @waxing = Product.active_products.waxing
    filtering_params(params).each do |key, value|
      @waxing = @waxing.active_products.public_send(key, value) if value.present?
    end
  end

  def show
    @product = Product.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def store
    @user = User.find_by_slug(params[:slug])
    if @user.respond_to? :products
      @products = @user.products.active_products
      filtering_params(params).each do |key, value|
        @products = @user.products.active_products.public_send(key, value) if value.present?
      end
    else
      flash.now[:alert] = 'The store you were looking for does not exist. Please select one of our merchants below.'
      redirect_to products_merchants_path
    end
  end

  def merchants
    verify_is_merchant
    @users = User.with_active_products.uniq
  end


  private
      def set_product
        @products = Product.find(params[:id])
      end


      def product_params
        params.require(:product).permit(:id, :name, :description, :status, :user_id, :price, :currency, :created_at, :updated_at, :photo, :size_details, :product_category, :product_subcategory, units_attributes: [:id, :product_id, :size, :quantity, :colour, :quantity_sold, :_destroy], :order_ids => [], productfotos_attributes: [:id, :product_id, :foto])
      end

      def find_or_create_cart
        if session[:cart] then
          @cart = session[:cart]
        else
          @cart = {}
        end
      end

      def filtering_params(params)
        params.slice(:category, :sub_category, :query, :sbp, :acc, :wax, :allfilter)
      end

      def verify_is_merchant
          (current_user.nil?) ? redirect_to(root_path) : (redirect_to(products_path) unless current_user.merchant?)
      end
end
