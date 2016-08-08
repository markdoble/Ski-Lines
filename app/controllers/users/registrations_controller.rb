class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => []

  def new
    super
    redirect_if_user_not_admin_or_rep
  end

  private
    def redirect_if_user_not_admin_or_rep
      if user_signed_in?
        redirect_to shop_path unless (current_user.admin? or current_user.merchant_rep?)
      end
    end

end
