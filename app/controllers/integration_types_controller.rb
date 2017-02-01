class IntegrationTypesController < ApplicationController
  layout "store_merchant_layout"
  before_action :authenticate_user!
  before_action :verify_is_admin

  # Gather the list of integration types to be displayed on the index
  def index
    @all_integration_types = IntegrationType.order(:id)
  end

  # Setup for the creation of a new integration type
  def new
    @integration_type = IntegrationType.new
  end

  # Will retrieve a single integration type to be displayed
  def show
    # Find the integration type given the ID
    @integration_type = IntegrationType.find(params[:id])
  end

  # Will retrieve a single integration type to be edited
  def edit
    # Find the integration type given the ID
    @integration_type = IntegrationType.find(params[:id])
  end

  # Will create a new integration type in the database given the parameters
  def create
    # Create the new integration type object
    @integration_type = IntegrationType.new(integration_type_params)

    # Try and save to the database. If we have errors, we will redirect to the new category form
    if @integration_type.save
      # Redirect to the index
      redirect_to integration_types_path
    else
      render 'new'
    end
  end

  # Will update an existing integration_type record in the database given the parameters
  def update
    # Find the existing integration type object by the ID
    @integration_type = IntegrationType.find(params[:id])

    # Try and update to the database. If we have errors, we will redirect to the edit integration_type form
    if @integration_type.update(integration_type_params)
      # Redirect to the index
      redirect_to integration_types_path
    else
      render 'edit'
    end
  end

  # Will remove an integration type entry from the database given an ID
  def destroy
    # Find the existing integration type objet by the ID
    @integration_type = IntegrationType.find(params[:id])

    # Delete the integration type and return to the index
    @integration_type.destroy
    redirect_to integration_types_path
  end

  # Private functions
  private

    # Define the required and permitted parameters for integration type request variables
    def integration_type_params
      params.require(:integration_type).permit(:name, :desc, :status, :auth_method, :always_authenticate)
    end

    # Verifies if the current user is logged in and is an admin
    # This will redirect them to the correct page
    def verify_is_admin
      (current_user.nil?) ? redirect_to(admin_products_path) : (redirect_to(admin_products_path) unless current_user.admin?)
    end
end
