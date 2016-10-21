class Admin::UsersController < ApplicationController
  # Define the layout to be used
  layout "store_merchant_layout"

  # Define the before_action elements
  before_action :authenticate_user!
  before_action :verify_is_admin

  # Gather the list of users to be displayed on the index
  def index
    @all_users = User.order(:id)
  end

  def merchants
    @merchants = User.where(merchant: true).where(merchant_rep: false)
  end

  # Gather the required information needed on the edit form
  def edit
    @userToEdit = User.find(params[:id])
  end

  # Executed when the edit user form is submitted
  def update
    # Load the user object from the database
    @userToEdit = User.find(params[:user_id])

    # Update the personal information fields
    @userToEdit.email = params[:email]
    @userToEdit.contact_first_name = params[:contact_first_name]
    @userToEdit.contact_last_name = params[:contact_last_name]

    # Update the address information fields
    @userToEdit.street_address = params[:street_address]
    @userToEdit.city = params[:city]
    @userToEdit.zip_postal = params[:zip_postal]
    @userToEdit.country = params[:country]
    @userToEdit.state_prov = params[:state_prov]

    # Update the user roles
    if params.has_key?(:admin_role)
      @userToEdit.admin = true
    else
      @userToEdit.admin = false
    end

    if params.has_key?(:merchant_role)
      @userToEdit.merchant = true
    else
      @userToEdit.merchant = false
    end

    if params.has_key?(:merchant_rep_role)
      @userToEdit.merchant_rep = true
    else
      @userToEdit.merchant_rep = false
    end

    if params.has_key?(:article_publisher_role)
      @userToEdit.article_publisher = true
    else
      @userToEdit.article_publisher = false
    end

    # Update the merchant specific fields
    @userToEdit.merchant_name = params[:user_merchant_name]
    @userToEdit.merchant_url = params[:merchant_url]
    @userToEdit.merchant_phone = params[:merchant_phone]
    @userToEdit.slug = params[:user_slug]
    if params.has_key?(:permitted_dest_ids)
      # Delete all the destinations that exist, but are not selected in the form
      @userToEdit.default_permitted_destinations.where(["country_id NOT IN (?)", params[:permitted_dest_ids]]).destroy_all
      # Add the destinations that do not exist, but are selected in the form
      params[:permitted_dest_ids].each do |dest_id|
        @userToEdit.default_permitted_destinations.find_or_create_by(user_id: @userToEdit.id, country_id: dest_id)
      end
    end
    @userToEdit.cad_domestic_shipping = params[:cad_domestic_shipping]
    @userToEdit.cad_foreign_shipping = params[:cad_foreign_shipping]
    @userToEdit.usd_domestic_shipping = params[:usd_domestic_shipping]
    @userToEdit.usd_foreign_shipping = params[:usd_foreign_shipping]

    # Update the password if it is provided
    if !params[:user_password].empty?
      @userToEdit.password = params[:user_password]
      @userToEdit.password_confirmation = params[:user_password]
    end

    # Persist the changes to the database
    @userToEdit.save

    # Redirect to the user list
    respond_to do |format|
      format.html {redirect_to admin_users_index_path}
    end
  end

  private
    def verify_is_admin
      (current_user.nil?) ? redirect_to(shop_path) : (redirect_to(shop_path) unless current_user.admin?)
    end

end
