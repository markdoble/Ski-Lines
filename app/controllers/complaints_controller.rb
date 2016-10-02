class ComplaintsController < ApplicationController
  layout "application"
  before_filter :find_or_create_cart
  before_filter :find_categories

  def new
    @complaint = Complaint.new
    if session[:complaint_session]
      if session[:complaint_expiry] < Time.current
        session.delete(:complaint_session)
        session.delete(:complaint_expiry)
      else
      @complaint_session = session[:complaint_session]
      end
    else
      @complaint_session = nil
    end
  end

  def clearComp
    session.delete(:complaint_session)
    session.delete(:complaint_expiry)
    redirect_to products_path
  end

  def create
    @complaint = Complaint.create(complaint_params)
    respond_to do |format|
      if @complaint.save
        create_complaint_session
        format.html { redirect_to new_complaint_path }

      else
        format.html { render :new }
        format.json { render json: @complaint.errors, status: :unprocessable_entity }
      end
    end
  end


 private
  def complaint_params
    params.require(:complaint).permit(:cust_first_name, :cust_last_name, :customer_email, :complaint_description, :accused_seller, :order_id_number)
  end

  def find_or_create_cart
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end
  end

  def find_categories
    @root_categories = Category.where(parent_id: nil).order(:name)
  end

  def create_complaint_session
    session[:complaint_session] = @complaint.id
    session[:complaint_expiry] = Time.current + 30
  end
end
