class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => []
  before_action :redirect_if_user_signed_in, :only => [:new]

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
    def redirect_if_user_signed_in
      if user_signed_in?
        unless (current_user.merchant_rep? || current_user.admin?)
          redirect_to shop_path
        end
      end
    end

end
