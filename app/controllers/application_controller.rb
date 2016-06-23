class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  before_filter :get_articles
  before_filter :site_stats
  #before_filter :set_cache_headers



  def site_stats

  @today = Article.where(publish: 'Yes').where("DATE(date_published) = ?", Time.zone.now.to_date).count
  @yesterday = Article.where(publish: 'Yes').where("DATE(date_published) = ?", Time.zone.yesterday.to_date).count

  end
  def get_articles
    @featured_articles = Article.publish.where(notes: 'Featured').order("date_published DESC", "created_at DESC", "description ASC")[2..4]
    @front_page_featured_articles = Article.publish.where(notes: 'Featured').order("date_published DESC", "created_at DESC", "description ASC").first(2)
    @featured_videos = Article.publish.where("image like ? OR image like ?", "%facebook%", "%youtube%").order("date_published DESC", "created_at DESC", "description ASC").first(3)
  end


  def after_sign_out_path_for(resource_or_scope)
    URI.parse(request.referer).path if request.referer
  end

  def configure_devise_permitted_parameters
      registration_params = [:admin, :merchant, :article_publisher, :slug, :contact_name, :email, :password, :password_confirmation, :merchant_name, :merchant_phone, :merchant_url, :country, :state_prov, :city, :street_address, :zip_postal, :shipping_cost, :sales_tax, :user_return_policy, :merchant_order_attributes => [:id, :user_id, :order_id, :product_id, :order_status, :delivery_method]]

      if params[:action] == 'update'
        devise_parameter_sanitizer.for(:account_update) {
          |u| u.permit(registration_params << :current_password)
        }
      elsif params[:action] == 'create'
        devise_parameter_sanitizer.for(:sign_up) {
          |u| u.permit(registration_params)
        }
      end
  end



  def set_cache_headers
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end


end
