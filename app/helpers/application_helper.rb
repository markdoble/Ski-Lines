module ApplicationHelper
  def nl2br(s)
    s.gsub(/\n/, '<br>')
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def select_create_form(current_user, f)
    if current_user.admin == true
      render partial: "devise/registrations/admin_new_user", locals: {:f => f}
    elsif current_user.merchant_rep == true
      render partial: "devise/registrations/new_merchant", locals: {:f => f}
    else
      render partial: "devise/registrations/form", locals: {:f => f}
    end
  end

end
