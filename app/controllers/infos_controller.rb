class InfosController < ApplicationController
  layout 'application'
  before_action :find_or_create_cart
  before_filter :find_categories

  def js_enabled

  end

  def terms

  end

  def return_policy

  end

  def purchase_information

  end

  def about

  end

  def merchant_faq

  end

  private
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
