class ProductsController < ApplicationController
  # Define the layout to be used
  layout "store_layout"

  # Define the before_action elements
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :find_or_create_cart

  # for pre-launch only:
  before_action :authenticate_user!


  # Default index action for the controller
  def index
    # Retrieve all the root categories to be displayed
    @root_categories = Category.where(parent_id: nil)
  end

  # Will retrieve all of the active products to be displayed
  def all_products
    # Retrieve all of the active products
    @products = Product.active_products

    # Check to see if we have to display a filtered list
    if !params[:category_id].nil?
      # A category filter exists, we will further filter the products
      @products = @products.category_specific(Category.find(params[:category_id]).descendents)
    end
  end

  # Will retrieve a single product to be displayed
  def show
    # Find the product given the ID
    @product = Product.find(params[:id])

    respond_to do |format|
      format.js
      format.html
    end
  end

  # Will retrieve all of the active products that relate to a specific merchant
  def store
    # Find the specified merchabt in the database given the slug
    @user = User.find_by_slug(params[:slug])

    # Retrieve all the root categories to be displayed
    @root_categories = Category.where(parent_id: nil)

    # Check to see if we have an existing merchant with products
    if @user.respond_to? :products
      # We have products to list. We will gather all of the acitve products for that merchant
      @products = @user.products.active_products

      # Check to see if we have to display a filtered list
      if !params[:category_id].nil?
        # A category filter exists, we will further filter the products
        @products = @products.category_specific(Category.find(params[:category_id]).descendents)
      end

      # Further filter the products if required
      filtering_params(params).each do |key, value|
        @products = @user.products.active_products.public_send(key, value) if value.present?
      end
    else
      # We do not have any products. We will alert the user and redirect
      flash.now[:alert] = 'The store you were looking for does not exist. Please select one of our merchants below.'
      redirect_to products_merchants_path
    end
  end

  # Will retrieve the list of merchants with active products
  def merchants
    verify_is_merchant
    @users = User.with_active_products.uniq
  end

  # Private functions
  private
    # To Do: Define what this function does
    def set_product
      @products = Product.find(params[:id])
    end

    # Define the required and permitted parameters for product request variables
    def product_params
      params.require(:product).permit(:id, :name, :description, :status, :user_id, :price, :currency, :created_at, :updated_at, :photo, :size_details, :product_category, :product_subcategory, units_attributes: [:id, :product_id, :size, :quantity, :colour, :quantity_sold, :_destroy], :order_ids => [], productfotos_attributes: [:id, :product_id, :foto])
    end

    # Define the required cart variable based on the session or empty
    def find_or_create_cart
      if session[:cart] then
        @cart = session[:cart]
      else
        @cart = {}
      end
    end

    # Define the parameters that are used for filtering
    def filtering_params(params)
      params.slice(:category, :query, :allfilter)
    end

    # Verifies if the current user is logged in and is a merchant
    # This will redirect to the correct page
    def verify_is_merchant
        (current_user.nil?) ? redirect_to(root_path) : (redirect_to(products_path) unless current_user.merchant?)
    end
end
