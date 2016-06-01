class InfosController < ApplicationController
  layout 'application'

  def js_enabled
    find_or_create_cart
  end

  def terms
    find_or_create_cart
  end

  def return_policy
    find_or_create_cart
  end

  def purchase_information
    find_or_create_cart
  end

  def about
    find_or_create_cart
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
