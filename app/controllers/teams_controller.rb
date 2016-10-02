class TeamsController < ApplicationController
  layout "application"
  before_filter :find_categories

  def new
    @team = Team.new
    @team_page = true
    find_or_create_cart
  end

  def create
    @team = Team.create(contact_params)
    respond_to do |format|
      if @team.save
        format.html { redirect_to articles_cross_country_url, notice: 'Thank you for applying to Ski-Lines.com! We will be in touch shortly.' }

      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end


 private
  def contact_params
    params.require(:team).permit(:first_name, :last_name, :email, :summary, :province, :city, :country)
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

end
