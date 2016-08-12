class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => []
  before_filter :redirect_if_user_not_admin_or_rep, :except => [:edit]

  def new
    super
  end

  def edit
    find_or_create_cart
    super
  end

  def find_or_create_cart
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end
  end

  private
    def redirect_if_user_not_admin_or_rep
      if user_signed_in?
        redirect_to shop_path unless (current_user.admin? or current_user.merchant_rep?)
      end
    end

end
