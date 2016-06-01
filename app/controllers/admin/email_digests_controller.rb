class Admin::EmailDigestsController < ApplicationController
  layout "admin_application"
  before_action :authenticate_user!
  before_action :verify_is_publisher

  def index
    @subscribers = EmailDigest.all
  end

  def send_digest

    article_ids = params[:article_ids]
    subject = params[:subject]

    EmailDigest.send_email_digest(article_ids, subject)

    session[:articleforemail] = params[:article_ids]
    session[:subjectforemail] = subject
    session[:mailexpiry] = Time.current + 20

    redirect_to '/admin/email_digests/new_digest'
  end

=begin
  def send_digest
    @subscribers = EmailDigest.all
    @article_ids = params[:article_ids]
    @articles = []
    @article_ids.each do |m|
      @articles << Article.find_by_id(m)
    end
    @subject = params[:subject]
    @subscribers.uniq.where.not(status: "Inactive").each do |subscriber|
       DigestMailer.weekly_digest(subscriber, @subject, @articles).deliver
    end
    session[:articleforemail] = @article_ids
    session[:subjectforemail] = @subject
    session[:mailexpiry] = Time.current + 100
    redirect_to '/admin/email_digests/new_digest'
  end
=end

  def new_digest
    if session[:articleforemail]
      if session[:mailexpiry] > Time.current
        @sent_subject = session[:subjectforemail]
        @sent_email = true
        @sent_articles = []
        session[:articleforemail].each do |m|
          @sent_articles << Article.find_by_id(m)
        end
      else
        session.delete(:articleforemail)
        session.delete(:subjectforemail)
        session.delete(:mailexpiry)
        @sent_email = false
      end
    else
      @sent_email = false
    end
    @article_selection = Article.cross_country_all.no_video[0...30]
  end


 private
  def email_digest_params
    params.require(:email_digest).permit(:first_name, :email, :last_name, :status)
  end

  def find_or_create_cart
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end
  end

  def verify_is_publisher
    (current_user.nil?) ? redirect_to(root_path) : (redirect_to(admin_products_path) unless current_user.article_publisher?)
  end



end
