class EmailDigestsController < ApplicationController
  layout "application"
  before_filter :find_or_create_cart

  def new
    @subscriber = EmailDigest.new
  end

  def create
    @subscriber = EmailDigest.create(email_digest_params)
    respond_to do |format|
      if @subscriber.save
        create_email_digest_session
        subscriber_id = @subscriber.id
        digest_welcome_email(subscriber_id)
        format.html { redirect_to root_path, notice: 'You have successfully subscribed to the Email Digest!' }
        format.js
      else
        format.html { redirect_to new_email_digest_path, notice: 'There was an error processing your subscription request. Please try again.' }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @subscriber = EmailDigest.find(params[:id])
    @featured_nf_products = Product.active_products.limit(2).order("RANDOM()")
  end

  def update
    @subscriber = EmailDigest.find(params[:id])
    respond_to do |format|
    if @subscriber.update(email_digest_params)
      format.html {redirect_to root_path, notice: 'Successfully saved changes to your subscription.'}
      format.json {render json: @subscriber }
      else
     redirect_to root_path
     end
   end
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


  def create_email_digest_session
    session[:email_digest_session] = @subscriber.id
    session[:email_digest_session_expiry] = Time.current + 60
  end

  def digest_welcome_email(subscriber_id)
    DigestMailer.welcome_mail(subscriber_id).deliver_later
  end

end
