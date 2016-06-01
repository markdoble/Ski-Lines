class Admin::TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_is_article_publisher
  layout "admin_application"
  def team
    @teams = Team.all
    @about_page = true
    find_or_create_cart
  end


  private
    def verify_is_article_publisher
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.article_publisher?)
    end

    def find_or_create_cart
      if session[:cart] then
        @cart = session[:cart]
      else
        @cart = {}
      end
    end


end
