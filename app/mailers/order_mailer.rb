class OrderMailer < ActionMailer::Base
  default from: "store@ski-lines.com"
  add_template_helper(OrdersHelper)
  
  def merchant_purchase_orders(order, user)
    @url = 'http://www.ski-lines.com'
    @order = order
    @user = user
    mail(to: @user.email, subject: 'You have a new order!')
    
  end
  
  
  def customer_purchase_order(order)
    @order = order
    @url = 'http://www.ski-lines.com'
    mail(to: @order.cust_email, subject: 'Your Ski-Lines Purchase Details')
    
  end
  
end
