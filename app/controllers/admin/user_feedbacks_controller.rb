class Admin::UserFeedbacksController < ApplicationController
  layout "admin_application"
  before_action :authenticate_user!
  before_action :verify_is_article_publisher

  def show
    @survey = Article.find(params[:id])
  end

  def index
    @all_surveys = Article.where(article_format: 'user_poll')
  end

  private
    def verify_is_article_publisher
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.article_publisher?)
    end

end
