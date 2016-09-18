class Admin::ProductsController < ApplicationController
  require 'csv'
  # Define the layout to be used
  layout "store_merchant_layout"

  # Define the before_action elements
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :verify_is_merchant

  # Define the required objects
  require 'paperclip'

  # Displays the index of all products for the current user
  def index
    if current_user.stripe_account_id.blank?
      redirect_to admin_stripe_accounts_new_stripe_account_path
    else
      # Retrieve all of the producs that belong to the current user
      @products = current_user.products.order("updated_at DESC")

      # Check to see if we have a query parameter. This is used for the product search bar
      if params[:query]
        @products = @products.search(params[:query])
      end

      # Check to see if we have a category id. This is used for the category dropdown filter
      if params[:category_id]
        @products = @products.category_specific(Category.find(params[:category_id]).descendents)
      end

      # Paginate the products list
      @products = @products.paginate(:page => params[:page],:per_page => 5)

      # list view products
      @list_view_products = current_user.products.order("updated_at DESC")

      # Check to see if we have a category id. This is used for the category dropdown filter
      if params[:category_id]
        @list_view_products = @list_view_products.category_specific(Category.find(params[:category_id]).descendents)
      end

      # Check to see if we have a query parameter. This is used for the product search bar on list view
      if params[:query]
          @list_view_products = @list_view_products.search(params[:query])
      end

      # Retrieve the root categories to display in the caterogy filter dropdown
      @all_categories = Category.order(:name)

      # Check to see if a user has selected a specific view type
      if params[:product_admin_view]
        # A view was selected, set it in the session
        session[:product_admin_view] = params[:product_admin_view]
      end

      # Check the session to see if a view type was selected, if not, load the detailed view by default
      if session[:product_admin_view]
        # A session value exists, load the correct view
        if session[:product_admin_view] == "list"
          render 'index_list'
        else
          render 'index'
        end
      else
        # A session value does not exist, load the default detailed view
        render 'index'
      end
    end
  end

  # Will retrieve a single product to be displayed
  def show
    @product = Product.find(params[:id])
  end

  # CSV upload to this action
  def import
    begin
      file = params[:file]
      CSV.foreach(file.path, headers: true) do |row|
        Product.create!(
          :brand => row['brand'],
          :name => row['model'],
          :description => row['description'],
          :status => false,
          :user_id => current_user.id,
          :size_details => row['size_details'],
          :product_return_policy => row['return_policy'],
          :usd_price => row['usd_price'].to_i,
          :cad_price => row['cad_price'].to_i,
          :factory_sku => row['sku'],
          :cad_domestic_shipping => current_user.cad_domestic_shipping,
          :cad_foreign_shipping => current_user.cad_foreign_shipping,
          :usd_domestic_shipping => current_user.usd_domestic_shipping,
          :usd_foreign_shipping => current_user.usd_foreign_shipping)
      end # end CSV.foreach
      redirect_to admin_products_url, notice: "Products successfully imported."
    rescue
      redirect_to admin_products_new_import_url, alert: "There was an error. Check your file and try again."
    end
  end

  # Setup for the creation of a new product
  def new

    @product = Product.new

    # Retrieve the root categories to display in the caterogy filter dropdown
    @all_categories = Category.order(:name)

    respond_to do |format|
      format.js
      format.html
    end
  end

  # Will retrieve a single product to be edited
  def edit
    @product = Product.find(params[:id])

    # Retrieve the categories to display in the caterogy filter dropdown
    @all_categories = Category.where(parent_id: nil).order(:name)
  end

  # Executed on submit of a new product. Will create the entry in the database
  def create
    # Create the new product object from the parameters received
    @product = Product.create(product_params)

    respond_to do |format|
      # Try and save the product to the database
      if @product.save
        update_nil_values(@product)
        # Product saved successfully. We will create the entry in the product_categories table
        @category = Category.find(params[:category_id])
        @product.product_categories.create(category: @category)

        # Redirect to the products list indicating success
        format.html { redirect_to admin_products_url, notice: 'Product was successfully added.' }
      else
        # Product did not save successfully. Redirect to the products list indicating failure

        # Retrieve the categories to display in the caterogy filter dropdown
        @all_categories = Category.order(:name)

        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # Executed on submit of an existing product. We will update the entry in the database
  def update
    # Find the existing product in the database
    @product = Product.find(params[:id])

    respond_to do |format|
      # Try and update the product in the database
      if @product.update(product_params)
        update_nil_values(@product)
        # Product updated successfully. We will update the entry in the product_categories table if required
        if !params[:category_id].nil?
          @category = Category.find(params[:category_id])
            # Check to see if we have product_categories to update
           if @product.product_categories.exists?
             @product.product_categories.update_all(category_id: @category.id)
           else
             @product.product_categories.create(category: @category)
           end
        end

        # Redirect to the products list
        format.html {redirect_to admin_products_url}
        format.json {respond_with_bip(@product) }
      else
        # Product did not update successfully

        # Retrieve the categories to display in the caterogy filter dropdown
        @all_categories = Category.order(:name)

        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
   end
 end

  # Executed when we want to delete a product
  def destroy
    # Find the existing product in the database
    @product = Product.find(params[:id])

    # Delete all of the entries in the product_categories table associated with this product
    @product.product_categories.destroy_all

    # Delete the product record itself
    @product.destroy
    respond_to do |format|
      # Redirect to the products list indicating success
      format.html { redirect_to admin_products_url, notice: 'Product was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # Private functions
  private
    # To Do: Define what this function does
    def set_product
      @products = Product.find(params[:id])
    end

    # Define the required and permitted parameters for product request variables
    def product_params
      params.require(:product).permit(
        :id,
        :name,
        :brand,
        :description,
        :status,
        :user_id,
        :price,
        :usd_price,
        :cad_price,
        :currency,
        :created_at,
        :updated_at,
        :photo,
        :size_details,
        :shipping_charge,
        :product_return_policy,
        :category_id,
        :cad_domestic_shipping,
        :cad_foreign_shipping,
        :usd_domestic_shipping,
        :usd_foreign_shipping,
        :factory_sku,
        :units_attributes => [
          :id,
          :product_id,
          :size,
          :quantity,
          :quantity_sold,
          :colour,
          :_destroy
          ],
        :order_ids => [],
        :country_ids => [],
        :productfotos_attributes => [
          :id,
          :product_id,
          :foto,
          :_destroy
          ]
        )
    end

    def update_nil_values(product)
      if product.usd_price == nil
        product.update_attribute(:usd_price, 0)
      end
      if product.cad_price == nil
        product.update_attribute(:cad_price, 0)
      end
      if product.cad_domestic_shipping == nil
        product.update_attribute(:cad_domestic_shipping, 0)
      end
      if product.cad_foreign_shipping == nil
        product.update_attribute(:cad_foreign_shipping, 0)
      end
      if product.usd_domestic_shipping == nil
        product.update_attribute(:usd_domestic_shipping, 0)
      end
      if product.usd_foreign_shipping == nil
        product.update_attribute(:usd_foreign_shipping, 0)
      end
    end

    # Verify if the current user is logged in and is a merchant
    def verify_is_merchant
      (current_user.nil?) ? redirect_to(shop_path) : (redirect_to(shop_path) unless current_user.merchant?)
    end
end
