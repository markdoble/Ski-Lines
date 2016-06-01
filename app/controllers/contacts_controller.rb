class ContactsController < ApplicationController
  layout "application"
  def new
    @contact = Contact.new
    find_or_create_cart
  end

  def js_enabled
  end



  def create
    @contact = Contact.create(contact_params)

  respond_to do |format|
    if @contact.save
      ContactMailer.contact_form_submit(@contact).deliver


      format.html { redirect_to articles_cross_country_url, notice: 'Thank you for contacting us! We will be in touch shortly.' }

    else
      format.html { render :new }
      format.json { render json: @contact.errors, status: :unprocessable_entity }
    end
  end
end

 private
  def contact_params
    params.require(:contact).permit(:email, :comment, :website)
  end

  def find_or_create_cart
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end
  end

end
