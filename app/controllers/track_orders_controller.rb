class TrackOrdersController < ApplicationController
  layout "application"
  before_filter :find_or_create_cart


  def my_order
    if session[:myorder]
      if session[:expired] < Time.current
        session.delete(:myorder)
        session.delete(:expired)
      else

        if session[:myorder] == 'no_order_found'
          @my_order_id = 'no_order_found'
        else
          @my_order_id = session[:myorder]
        end
      end
    else
      @my_order_id = nil
    end
  end

  def track
    if order = Order.find_by_id(params[:order_id])
      if order.cust_first_name == params[:first_name] && order.cust_last_name == params[:last_name] && order.cust_email == params[:email]
        session[:myorder] = params[:order_id]
        session[:expired] = Time.current + 30
      else
        session[:myorder] = 'no_order_found'
        session[:expired] = Time.current + 30
      end
    else
      session[:myorder] = 'no_order_found'
      session[:expired] = Time.current + 30
    end
    redirect_to track_orders_my_order_path
  end

  def clear_track_order
    session.delete(:myorder)
    session.delete(:expired)
    redirect_to products_path
  end
  def try_again
    session.delete(:myorder)
    session.delete(:expired)
    redirect_to track_orders_my_order_path
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
