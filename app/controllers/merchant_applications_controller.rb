class MerchantApplicationsController < ApplicationController
  layout "application"
  before_filter :find_or_create_cart



  def new
    @merchant_application = MerchantApplication.new
    if session[:merchant_application]
      if  session[:merchant_app_expiry] < Time.current
        session.delete(:merchant_application)
        session.delete(:merchant_app_expiry)
      else
          @merchant_application_session = session[:merchant_application]
      end
    else
      @merchant_application_session = nil
    end
  end

  def clearApp
    session.delete(:merchant_application)
    session.delete(:merchant_app_expiry)
    redirect_to products_path
  end

  def create
    @merchant_application = MerchantApplication.create(merchant_app_params)
    respond_to do |format|
      if @merchant_application.save
        create_merchant_app_session
        format.html { redirect_to new_merchant_application_path }

      else
        format.html { render :new }
        format.json { render json: @merchant_application.errors, status: :unprocessable_entity }
      end
    end
  end


 private
  def merchant_app_params
    params.require(:merchant_application).permit(:merchant_name, :email, :state_prov, :city, :country, :zip_postal, :street_address, :contact_name, :merchant_phone, :current_selling_online, :website_url)
  end

  def find_or_create_cart
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end
  end


  def create_merchant_app_session
    session[:merchant_application] = @merchant_application.id
    session[:merchant_app_expiry] = Time.current + 30
  end


end
