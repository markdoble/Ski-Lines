class Admin::ProductCategoriesController < ApplicationController
  layout "store_merchant_layout"
  before_action :authenticate_user!
  before_filter :verify_is_admin


  def index
    @product_categories = ProductCategory.all 
    @product_category = ProductCategory.new
    
  end
  
  def show
    @product_category = ProductCategory.find(params[:id]) 
  end
  
  def new
    @product_category = ProductCategory.new
  end

  def create
    @product_category = ProductCategory.create(product_category_params)
    respond_to do |format|
      if @product_category.save
        format.html { redirect_to admin_product_categories_url, notice: 'Category was successfully created.' }
        
      else
        format.html { render :new }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
     @product_category = ProductCategory.find(params[:id]) 
  end
  
  def update
     @product_category = ProductCategory.find(params[:id]) 
    respond_to do |format|
    if @product_category.update(product_category_params)
      format.html {redirect_to admin_product_categories_url}
      format.json {render json: @product_category }
      else
     redirect_to admin_product_categories_url
     end
   end
  end
  
  def destroy
    @product_category = ProductCategory.find(params[:id]) 
    @product_category.destroy
    respond_to do |format|
      format.html { redirect_to admin_product_categories_url, notice: 'Category was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  
  
  private
    def set_product_cetegory
      @product_category = ProductCategory.find(params[:id]) 
    end


    def product_category_params
      params.require(:product_category).permit(:id, :category, product_subcategories_attributes: [:id, :product_category_id, :subcategory])
    end
    
    def verify_is_admin
      (current_user.nil?) ? redirect_to(admin_products_path) : (redirect_to(admin_products_path) unless current_user.admin?)
    end
  
  
end
