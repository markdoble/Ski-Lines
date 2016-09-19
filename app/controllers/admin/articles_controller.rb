class Admin::ArticlesController < ApplicationController
  layout "admin_application"
  before_action :set_article, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_filter :verify_is_article_publisher
  # GET /articles
  # GET /articles.json
  def index
    if params[:filter] == "all"
    @articles = Article.admin_cross_country_all.paginate(:page => params[:page],:per_page => 10)
    elsif params[:filter] == "feat"
    @articles = Article.article_featured.paginate(:page => params[:page],:per_page => 10)
    elsif params[:filter] == "pub"
    @articles = Article.cross_country_all.paginate(:page => params[:page],:per_page => 10)
    elsif params[:filter] == "unpub"
    @articles = Article.admin_cross_country_unpub.paginate(:page => params[:page],:per_page => 10)
    elsif params[:filter] == "never"
    @articles = Article.admin_never_publish.paginate(:page => params[:page],:per_page => 10)
    elsif params[:filter] == "pending"
    @articles = Article.admin_publish_pending.paginate(:page => params[:page],:per_page => 10)
    else
    @articles = Article.admin_cross_country_unpub.paginate(:page => params[:page],:per_page => 10)
    end
    respond_to do |format|
      format.html
      format.js
      format.rss { render :layout => false }
    end
  end

  # GET /articles/1
  # GET /articles/1.json


  # GET /articles/new
  def new
    @article = Article.new
    @article.build_user_feedback
    @about_page = true
  end

  # GET /articles/1/edit
  def edit
    @about_page = true
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.create(article_params)
    if @article.location == "custom_ski_lines_article_location"
      @article.location = @article.id.to_s.prepend("https://www.ski-lines.com/articles/")
    end
    respond_to do |format|
      if @article.save
        if @article.publish == 'Yes'
          send_to_slack(@article)
        end
        format.html { redirect_to admin_articles_url, notice: 'Article was successfully created.' }

      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
   respond_to do |format|
   if @article.update(article_params)
     if @article.publish == 'Yes'
       send_to_slack(@article)
     end
     format.html {redirect_to admin_articles_url}
     format.json {render json: @article }
     else
    redirect_to admin_articles_url
    end
  end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to admin_articles_url, notice: 'Article was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end


    def article_params
      params.require(:article).permit(:id, :location, :category, :title, :description, :source, :created_at, :updated_at, :date_published, :notes, :image, :publish, :article_format, :img_size, :orig_content_photo, :user_feedback_attributes => [:article_id, :id, :question_one, :question_two, :question_three, :question_four, :question_five, :question_six])
    end

    def verify_is_article_publisher
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.article_publisher?)
    end

    def send_to_slack(article)
      notifier = Slack::Notifier.new ENV["WEBHOOK_URL"]
      notifier.ping "New article published, entitled: " << article.title
    end

end
