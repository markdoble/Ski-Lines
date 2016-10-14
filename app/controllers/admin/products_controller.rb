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

      # Retrieve the root categories to display in the caterogy filter dropdown
      @all_categories = Category.order(:name)

      # Check to see if a user has selected a specific view type
      if params[:product_admin_view]
        # A view was selected, set it in the session
        session[:product_admin_view] = params[:product_admin_view]
      end

      # check to see if rep has selected a merchant
      if params[:merchant_selected]
        # A merchant was selected, set it in the session
        session[:merchant_selected] = params[:merchant_selected]
      end

      # Check the session to see if a view type was selected, if not, load the detailed view by default
      if session[:product_admin_view]
        # A session value exists, load the correct view
        if session[:product_admin_view] == "list"
          @page_view = 'list'
          # Retrieve all of the producs that belong to the current user
            # filter products for rep based on merchant selected
          if !session[:merchant_selected].blank? && current_user.merchant_rep?
            user = User.find(session[:merchant_selected])
            @merchant_name = user.merchant_name
            @products = user.products.order("updated_at DESC")
          else
            @merchant_name = current_user.merchant_name
            @products = current_user.products.order("updated_at DESC")
          end

          # Check to see if we have a query parameter. This is used for the product search bar
          if params[:query]
            @products = @products.search(params[:query])
          end

          # Check to see if we have a category id. This is used for the category dropdown filter
          if params[:category_id]
            @products = @products.category_specific(Category.find(params[:category_id]).descendents)
          end

        else
          @page_view = 'detailed'

          # Retrieve all of the producs that belong to the current user
            # filter products for rep based on merchant selected
          if !session[:merchant_selected].blank? && current_user.merchant_rep?
            # find user with param passed in
            user = User.find(session[:merchant_selected])
            #set the merchants name
            @merchant_name = user.merchant_name
            # paginate the products for detailed view
            @products = user.products.order("updated_at DESC").paginate(:page => params[:page],:per_page => 5)
          else
            # if rep hasn't selected a merchant, display the rep's name
            @merchant_name = current_user.merchant_name
            # if rep hasn't selected a merchant, display the rep's products
            @products = current_user.products.order("updated_at DESC").paginate(:page => params[:page],:per_page => 5)
          end

          # Check to see if we have a category id. This is used for the category dropdown filter
          if params[:category_id]
            @products = @products.category_specific(Category.find(params[:category_id]).descendents)
          end

          # Check to see if we have a query parameter. This is used for the product search bar on list view
          if params[:query]
              @products = @products.search(params[:query])
          end

        end
      else
        # A session value does not exist, load the default detailed view
        @page_view = 'list'

        # filter products for rep based on merchant selected
        if !session[:merchant_selected].blank? && current_user.merchant_rep?
          # select the user based on rep's selection
          user = User.find(session[:merchant_selected])
          # set the merchant name selected by the rep
          @merchant_name = user.merchant_name
          # list the products belonging to the selected merchant in list form
          @products = user.products.order("updated_at DESC")
        else
          # set merchant name to current user's name
          @merchant_name = current_user.merchant_name
          # list all the products for the current user, merchant or rep
          @products = current_user.products.order("updated_at DESC")
        end

        # Check to see if we have a query parameter. This is used for the product search bar
        if params[:query]
          @products = @products.search(params[:query])
        end

        # Check to see if we have a category id. This is used for the category dropdown filter
        if params[:category_id]
          @products = @products.category_specific(Category.find(params[:category_id]).descendents)
        end

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
      if params[:user_id]
        user = User.find_by_id(params[:user_id])
      else
        user = current_user
      end
      CSV.foreach(file.path, headers: true) do |row|
        Product.create!(
          :brand => row['brand'],
          :name => row['model'],
          :description => row['description'],
          :status => false,
          :user_id => user.id,
          :size_details => row['size_details'],
          :product_return_policy => row['return_policy'],
          :usd_price => row['usd_price'].to_i,
          :cad_price => row['cad_price'].to_i,
          :factory_sku => row['sku'],
          :cad_domestic_shipping => user.cad_domestic_shipping,
          :cad_foreign_shipping => user.cad_foreign_shipping,
          :usd_domestic_shipping => user.usd_domestic_shipping,
          :usd_foreign_shipping => user.usd_foreign_shipping)
      end # end CSV.foreach
      redirect_to admin_products_url, notice: "Products successfully imported."
    rescue
      redirect_to admin_products_new_import_url, alert: "There was an error. Check your file and try again."
    end
  end

  def choose_from_stock
    begin
      if params[:user_id]
        user = User.find_by_id(params[:user_id])
      else
        user = current_user
      end
      stock_product = Stockproduct.find_by_id(params[:stock_product])

      # if MSRP is nil or zero, set price variables to 0.
      (stock_product.usd_msrp.nil? || stock_product.usd_msrp == 0) ? (usd_price = 0) : usd_price = stock_product.usd_msrp
      (stock_product.cad_msrp.nil? || stock_product.cad_msrp == 0) ? (cad_price = 0) : cad_price = stock_product.cad_msrp

      # if shipping prices are nil, set to zero
      (user.cad_domestic_shipping.nil?) ? (cad_domestic_shipping = 0) : ( cad_domestic_shipping = user.cad_domestic_shipping )
      (user.cad_foreign_shipping.nil?) ? (cad_foreign_shipping = 0) : ( cad_foreign_shipping = user.cad_foreign_shipping )
      (user.usd_domestic_shipping.nil?) ? (usd_domestic_shipping = 0) : ( usd_domestic_shipping = user.usd_domestic_shipping )
      (user.usd_foreign_shipping.nil?) ? (usd_foreign_shipping = 0) : ( usd_foreign_shipping = user.usd_foreign_shipping )

      # create new product from the stock product
      new_product = Product.create!(
        :brand => stock_product.brand,
        :name => stock_product.name,
        :description => stock_product.description,
        :status => false,
        :user_id => user.id,
        :size_details => stock_product.size_details,
        :product_return_policy => user.user_return_policy,
        :usd_price => usd_price,
        :cad_price => cad_price,
        :factory_sku => stock_product.sku,
        :cad_domestic_shipping => cad_domestic_shipping,
        :cad_foreign_shipping => cad_foreign_shipping,
        :usd_domestic_shipping => usd_domestic_shipping,
        :usd_foreign_shipping => usd_foreign_shipping,
      )

      ProductStockphoto.create!(
        :product_id => new_product.id,
        :stockphoto_id => stock_product.stockphoto.id
      )
      

      # for each stockproductfoto, create a new nested productfoto for the product
      stock_product.stockproductfotos.each do |f|
        ProductStockproductfoto.create!(
          :product_id => new_product.id,
          :stockproductfoto_id => f.id
        )
      end
      # make instance variable available for javascript response choose_from_stock.js.erb
      @product_id = stock_product.id
      respond_to do |format|
            format.js { render 'admin/products/choose_from_stock', notice: 'Product was successfully added.' }
            format.html { redirect_to admin_products_stock_product_upload_path, notice: 'Product was successfully added.' }
        end
    rescue
      redirect_to admin_products_stock_product_upload_path, alert: 'Product addition failed.'
    end
  end

  def stock_product_upload
    # create array of brands to filter with
    @brands = Stockproduct.uniq { |p| p.brand }.map{|b| b.brand }.uniq

    # check to see if admin has selected a brand
    if params[:brand_selected]
      # A brand was selected, set it in the session
      session[:brand_selected] = params[:brand_selected]
    end
    # create array of products owned by the merchant that were created by stock product
    merchants_stockproducts = current_user.products.where(photo_file_name: nil)
    # create an array of Stockproducts that were used to create the product owned by user
    # and use the excluded_products array to prevent those products from rendering on page
       # by subtracting the excluded_products array from the @stockproducts array below.
    excluded_products = []
    merchants_stockproducts.each do |prod|
      unless prod.stockphoto.blank?
      excluded_products << prod.stockphoto.stockproduct.id
      end
    end

    # Retrieve all of the producs that belong to the brand
      # filter products for admin based on brand selected
    if !session[:brand_selected].blank?
      if current_user.country == "United States of America"
          @stockproducts = Stockproduct.where(brand: session[:brand_selected]).where(us_status: true).where.not(id: excluded_products).paginate(:page => params[:page],:per_page => 5)
      elsif current_user.country == "Canada"
          @stockproducts = Stockproduct.where(brand: session[:brand_selected]).where(ca_status: true).where.not(id: excluded_products).paginate(:page => params[:page],:per_page => 5)
      end
    else
      if current_user.country == "United States of America"
          @stockproducts = Stockproduct.where(us_status: true).where.not(id: excluded_products).paginate(:page => params[:page],:per_page => 5)
      elsif current_user.country == "Canada"
          @stockproducts = Stockproduct.where(ca_status: true).where.not(id: excluded_products).paginate(:page => params[:page],:per_page => 5)
      end

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
