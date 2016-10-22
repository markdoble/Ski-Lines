class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  # Define the before_action elements
  before_filter :get_articles
  before_filter :site_stats
  before_filter :find_or_create_cart
  before_filter :site_country_selection
  before_filter :get_site_categories

  # helper for mailboxer
  helper_method :mailbox, :conversation

  # Defines the variables used to display the total count of artices for today abd yesterday
  def site_stats
    @today = Article.where(publish: 'Yes').where("DATE(date_published) = ?", Time.zone.now.to_date).count
    @yesterday = Article.where(publish: 'Yes').where("DATE(date_published) = ?", Time.zone.yesterday.to_date).count
  end

  # Defines the artices to be displayed
  def get_articles
    @featured_articles = Article.publish.where(article_format: 'standard').where(notes: 'Featured').order("date_published DESC", "created_at DESC", "description ASC")[2..6]
    @front_page_featured_articles = Article.publish.where(article_format: 'standard').where(notes: 'Featured').order("date_published DESC", "created_at DESC", "description ASC").first(2)
    @featured_videos = Article.publish.where("article_format like ? OR article_format like ?", "%facebook_video%", "%youtube_video%").order("date_published DESC", "created_at DESC", "description ASC").first(3)
  end

  # Defines the categories that are available on the site. Will be used for filtering purposes
  def get_site_categories
    @site_root_categories = Category.where(parent_id: nil).order(:name)
  end

  # To Do: Define what this does
  def after_sign_out_path_for(resource_or_scope)
    shop_path
  end

  # Define the required and permitted parameters for devise
  def configure_devise_permitted_parameters
      registration_params = [:admin,
                            :merchant,
                            :article_publisher,
                            :slug,
                            :contact_first_name,
                            :contact_last_name,
                            :email,
                            :password,
                            :password_confirmation,
                            :merchant_name,
                            :merchant_phone,
                            :merchant_url,
                            :country,
                            :state_prov,
                            :city,
                            :street_address,
                            :zip_postal,
                            :shipping_cost,
                            :usd_domestic_shipping,
                            :usd_foreign_shipping,
                            :cad_domestic_shipping,
                            :cad_foreign_shipping,
                            :sales_tax,
                            :user_return_policy,
                            :merchant_rep,
                            :email_for_orders,
                            :country_ids => [],
                            :merchant_order_attributes => [:id,
                                    :user_id,
                                    :order_id,
                                    :product_id,
                                    :order_status,
                                    :delivery_method
                                  ]
                            ]

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

  # To Do: Define what this does
  def set_cache_headers
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  # Executed from the country select modal window. Will change the value in the current user session and reload the page
  def change_site_country
    session[:site_country] = params[:country]
    redirect_to :back
  end

  # Private functions
  private

  # Defines the mailbox for the current user
  def mailbox
    @mailbox ||= current_user.mailbox
  end

  # Defines a converation for the current user mailbox by ID
  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  # Define the cart to use
  def find_or_create_cart
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end
  end

  # Will determine the user's country and set it in the session to use throughout the site
  def site_country_selection
    if !session[:site_country] then
      session[:site_country] = "ca"
    end
  end

  # Will return the correct currency string depending on the site country specified
  # If a country does not belong to the select case, a blank string will be returned
  def currency_session(site_country)
    case site_country
      when "ca"
        "CAD"
      when "us"
        "USD"
      else
        ""
    end
  end

end
