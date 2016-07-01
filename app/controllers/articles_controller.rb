class ArticlesController < ApplicationController
  require 'will_paginate/array'
  layout 'articles_layout'
  before_filter :find_or_create_cart

  def show
    @featured_nf_products = Product.active_products.limit(2).order("RANDOM()")
    @show = true
    any_article = Article.find(params[:id])
    # if article has been published, set article instance variable, else redirect to root.
    (any_article.publish == "Yes") ? (@article = any_article) : (redirect_to root_url, :flash => { :error => "Article not found." })
  end

  def index
    @articles = Article.cross_country_all.where.not(notes: "Sponsor")
  end

  def cross_country
    @index_page = true
    @articles_rss = Article.cross_country_all.where.not(notes: "Sponsor").paginate(:page => params[:page],:per_page => 5)
    if params[:videos] == "videos"
       @articles = Article.cross_country_all.video_filter.paginate(:page => params[:page],:per_page => 5)
     else
       if params[:query]
         @articles = Article.cross_country_all.search(params[:query]).paginate(:page => params[:page],:per_page => 5)
         else
         @articles = Article.cross_country_all.paginate(:page => params[:page],:per_page => 5)
       end
     end
     @subscriber = EmailDigest.new
     if session[:email_digest_session]
       if  session[:email_digest_session_expiry] < Time.current
         session.delete(:email_digest_session)
         session.delete(:email_digest_session_expiry)
       else
           @subscriber_session = session[:email_digest_session]
       end
     else
       @subscriber_session = nil
     end
    @featured_nf_products = Product.active_products.limit(2).order("RANDOM()")
    respond_to do |format|
      format.html
      format.js
      format.rss { render :layout => false }
    end
  end

  private
    def find_or_create_cart
      if session[:cart] then
        @cart = session[:cart]
      else
        @cart = {}
      end
    end

end
