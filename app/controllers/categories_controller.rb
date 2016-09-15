class CategoriesController < ApplicationController
  # Define the layout to be used
  layout "store_merchant_layout"

  # Define the before_action elements
  before_action :authenticate_user!, :except => [:update_subcategories]
  before_filter :verify_is_admin, :except => [:update_subcategories]

  # Will retrieve all of the root categories that exist to display on the index
  def index
    # Retrieve all the root categories to be displayed. They will be ordered by name by default
    @root_categories = Category.where(parent_id: nil).order(:name)

    # Define a new category object to be used on the index page to quick create a new root category
    @category = Category.new
  end

  # Will retrieve a single category to be displayed
  def show
    # Find the category given the ID
    @category = Category.find(params[:id])
  end

  # Setup for the creation of a new category
  def new
    @category = Category.new
  end

  # Will retrieve a single category to be edited
  def edit
    @category = Category.find(params[:id])
  end

  # Will create a new category in the database given the parameters
  def create
    # Create the new category object
    @category = Category.new(category_params)

    # Try and save to the database. If we have errors, we will redirect to the new category form
    if @category.save
      # Redirect to the category list
      redirect_to categories_path
    else
      render 'new'
    end
  end

  # Will update an existing category in the database given the parameters
  def update
    # Find the existing category object by the ID
    @category = Category.find(params[:id])

    # Try and update to the database. If we have errors, we will redirect to the edit category form
    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end

  # Will remove a category entry from the database given an ID
  def destroy
    # Find the existing category objet by the ID
    @category = Category.find(params[:id])

    # Delete the category and return to the index
    @category.destroy
    redirect_to categories_path
  end

  # Will retrieve the immediate subcategories of a parent category
  # This function is called with Ajax and returns the list of category objects in Json format
  def update_subcategories
    @subcategories = Category.where("parent_id = ?", params[:parent_id]).order(:name)
    respond_to do |format|
      format.json  { render :json => @subcategories }
    end
  end

  # Private functions
  private

    # Define the required and permitted parameters for category request variables
    def category_params
      params.require(:category).permit(:name, :description, :parent_id)
    end

    # Verifies if the current user is logged in and is an admin
    # # This will redirect them to the correct page
    def verify_is_admin
      (current_user.nil?) ? redirect_to(admin_products_path) : (redirect_to(admin_products_path) unless current_user.admin?)
    end

end
