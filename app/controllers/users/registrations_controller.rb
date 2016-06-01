class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => []
  before_filter :verify_is_admin, :except => [:edit, :update]


  def new
    super
  end

  private
  
  def verify_is_admin
    (current_user.nil?) ? redirect_to(admin_products_path) : (redirect_to(admin_products_path) unless current_user.admin?)
  end


end