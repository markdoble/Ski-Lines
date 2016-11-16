class Admin::StockproductsController < ApplicationController
  require 'csv'
  # Define the layout to be used
  layout "store_merchant_layout"

  # Define the before_action elements
  before_action :set_stockproduct, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  before_action :verify_permission

  # Define the required objects
  require 'paperclip'

  # Displays the index of all products for the current user
  def index

      @brands = Stockproduct.uniq { |p| p.brand }.map{|b| b.brand }.uniq

      # Retrieve the root categories to display in the caterogy filter dropdown
      @all_categories = Category.order(:name)

      # check to see if admin has selected a brand
      if params[:brand_selected]
        # A brand was selected, set it in the session
        session[:brand_selected] = params[:brand_selected]
      end

      # Retrieve all of the producs that belong to the brand
        # filter products for admin based on brand selected
      if !session[:brand_selected].blank?
        @stockproducts = Stockproduct.where(brand: session[:brand_selected]).order("updated_at DESC").paginate(:page => params[:page],:per_page => 5)
      else
        @stockproducts = Stockproduct.all.order("updated_at DESC").paginate(:page => params[:page],:per_page => 5)
      end

      # Check to see if we have a category id. This is used for the category dropdown filter
      if params[:category_id]
        @stockproducts = @stockproducts.category_specific(Category.find(params[:category_id]).descendents)
      end

      # Check to see if we have a query parameter. This is used for the product search bar
      if params[:query]
        @stockproducts = @stockproducts.search(params[:query])
      end
  end

  # Will retrieve a single product to be displayed
  def show
    @stockproduct = Stockproduct.find(params[:id])
    # if no units, don't redirect.
    if @stockproduct.stockunits.any?
      if @stockproduct.stockunits.any?{ |m| m.size != 'n/a' && m.colour != 'n/a' }
        redirect_to admin_stockproduct_size_and_colour_path(:stockproduct_id => @stockproduct.id)
      elsif @stockproduct.stockunits.any?{ |m| m.size == 'n/a' && m.colour != 'n/a' }
        redirect_to admin_stockproduct_colour_only_path(:stockproduct_id => @prostockproductduct.id)
      elsif @stockproduct.stockunits.any?{ |m| m.size != 'n/a' && m.colour == 'n/a' }
        redirect_to admin_stockproduct_size_only_path(:stockproduct_id => @stockproduct.id)
      elsif @stockproduct.stockunits.any?{|m| m.size == 'n/a' && m.colour == 'n/a' }
        redirect_to admin_stockproduct_unit_only_path(:stockproduct_id => @stockproduct.id)
      end
    end
  end

  def inventory
    @stockproduct = Stockproduct.find(params[:id])
    inventory_type = [params[:size], params[:colours]]
    case inventory_type
    when ["true", "true"]
      redirect_to admin_stockproduct_size_and_colour_path(:stockproduct_id => @stockproduct.id)
    when ["false", "true"]
      redirect_to admin_stockproduct_colour_only_path(:stockproduct_id => @stockproduct.id)
    when ["true", "false"]
      redirect_to admin_stockproduct_size_only_path(:stockproduct_id => @stockproduct.id)
    when ["false", "false"]
      redirect_to admin_stockproduct_unit_only_path(:stockproduct_id => @stockproduct.id)
    end
  end

  # following four actions are specific show pages for eidting inventory. See above show action.
  def size_and_colour
    @stockproduct = Stockproduct.find(params[:stockproduct_id])
  end

  def colour_only
    @stockproduct = Stockproduct.find(params[:stockproduct_id])
  end

  def size_only
    @stockproduct = Stockproduct.find(params[:stockproduct_id])
  end

  def unit_only
    @stockproduct = Stockproduct.find(params[:stockproduct_id])
  end

  # CSV upload to this action
  def import
    begin
      file = params[:file]
      CSV.foreach(file.path, headers: true) do |row|
        Stockproduct.create!(
          :brand => row['brand'],
          :name => row['model'],
          :description => row['description'],
          :ca_status => false,
          :us_status => false,
          :size_details => row['size_details'],
          :cad_msrp => row['cad_msrp'].to_i,
          :usd_msrp => row['usd_msrp'].to_i,
          :sku => row['sku']
          )
      end # end CSV.foreach
      redirect_to admin_stockproducts_url, notice: "Products successfully imported."
    rescue
      redirect_to admin_stockproducts_new_import_url, alert: "There was an error. Check your file and try again."
    end
  end

  # Setup for the creation of a new product
  def new
    @stockproduct = Stockproduct.new
    @stockproduct.build_stockphoto
    # Retrieve the root categories to display in the caterogy filter dropdown
    @all_categories = Category.order(:name)
    respond_to do |format|
      format.js
      format.html
    end
  end

  # Will retrieve a single product to be edited
  def edit
    @stockproduct = Stockproduct.find(params[:id])

    # Retrieve the categories to display in the caterogy filter dropdown
    @all_categories = Category.where(parent_id: nil).order(:name)
  end

  # Executed on submit of a new product. Will create the entry in the database
  def create
    # Create the new product object from the parameters received
    @stockproduct = Stockproduct.create(stockproduct_params)

    respond_to do |format|
      # Try and save the product to the database
      if @stockproduct.save
        update_status(@stockproduct)
        @category = Category.find(params[:category_id])
        @stockproduct.stockproduct_categories.create(category: @category)
        # Redirect to the products list indicating success
        format.html { redirect_to admin_stockproducts_url, notice: 'Product was successfully added.' }
      else
        # Product did not save successfully. Redirect to the products list indicating failure

        # Retrieve the categories to display in the caterogy filter dropdown
        @all_categories = Category.order(:name)

        format.html { render :new }
        format.json { render json: @stockproduct.errors, status: :unprocessable_entity }
      end
    end
  end

  # Executed on submit of an existing product. We will update the entry in the database
  def update
    # Find the existing product in the database
    @stockproduct = Stockproduct.find(params[:id])

    respond_to do |format|
      # Try and update the product in the database
      if @stockproduct.update(stockproduct_params)

        if !params[:category_id].nil?
          @category = Category.find(params[:category_id])
            # Check to see if we have product_categories to update
           if @stockproduct.stockproduct_categories.exists?
             @stockproduct.stockproduct_categories.update_all(category_id: @category.id)
           else
             @stockproduct.stockproduct_categories.create(category: @category)
           end
        end

        # Redirect to the products list
        format.html {redirect_to admin_stockproducts_url}
        format.json {respond_with_bip(@stockproduct) }
      else
        format.html { render :new }
        format.json { render json: @stockproduct.errors, status: :unprocessable_entity }
      end
   end
 end

  # Executed when we want to delete a product
  def destroy
    # Find the existing product in the database
    @stockproduct = Stockproduct.find(params[:id])

    # Delete the product record itself
    @stockproduct.destroy
    respond_to do |format|
      # Redirect to the products list indicating success
      format.html { redirect_to admin_stockproducts_url, notice: 'Product was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # Private functions
  private
    # To Do: Define what this function does
    def set_stockproduct
      @stockproduct = Stockproduct.find(params[:id])
    end

    # Define the required and permitted parameters for product request variables
    def stockproduct_params
      params.require(:stockproduct).permit(
        :name,
        :brand,
        :description,
        :size_details,
        :sku,
        :cad_msrp,
        :usd_msrp,
        :us_status,
        :ca_status,
        :stockphoto_attributes => [
          :id,
          :photo,
          :stockproduct_id,
          :sku,
          :name,
          :_destroy
        ],
        :stockproductfotos_attributes => [
          :id,
          :stockproduct_id,
          :foto,
          :_destroy
        ],
        :stockunits_attributes => [
          :id,
          :stockproduct_id,
          :size,
          :quantity,
          :colour,
          :_destroy
          ],
        )
    end

    # Verify if the current user is logged in and has permission to access stock products
    def verify_permission
      (current_user.nil?) ? redirect_to(shop_path) : (redirect_to(shop_path) unless current_user.stockproduct_permission?)
    end

    def update_status(stockproduct)
      if stockproduct.us_status == nil
        stockproduct.update_attribute(:us_status, false)
      end
      if stockproduct.ca_status == nil
        stockproduct.update_attribute(:ca_status, false)
      end
    end
end
