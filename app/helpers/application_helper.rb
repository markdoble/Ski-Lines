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

  def select_user_create_form(current_user)
    if current_user.admin == true
      render partial: "devise/registrations/new_partials/admin_new_user"
    elsif current_user.merchant_rep == true
      render partial: "devise/registrations/new_partials/new_merchant"
    else
      render partial: "devise/registrations/new_partials/form"
    end
  end

  def select_uer_edit_form(current_user)
    if current_user.admin == true
      render partial: "devise/registrations/edit_partials/edit_admin"
    elsif current_user.merchant_rep == true
      render partial: "devise/registrations/edit_partials/edit_staff"
    elsif current_user.article_publisher == true
      render partial: "devise/registrations/edit_partials/edit_staff"
    elsif current_user.merchant?
      render partial: "devise/registrations/edit_partials/edit_merchant"
    else
      render partial: "devise/registrations/edit_partials/edit_form"
    end
  end

  # used to define the active page for mailboxer folders
  def active_page(active_page)
    @active == active_page ? "active" : ""
  end

end
