module DeviseHelper

  def select_create_form(current_user)
    if current_user.admin == true
      render partial: "devise/registrations/admin_new_user"
    elsif current_user.merchant_rep == true
      render partial: "devise/registrations/new_merchant"
    else
      render partial: "devise/registrations/form"
    end
  end

end
