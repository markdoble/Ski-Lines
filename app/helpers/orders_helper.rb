module OrdersHelper

  def calculate_sub_total(order)
    subtotal = 0
    order.order_units.where.not(quantity: 0).each do |f|
      subtotal += (f.unit.product.price*f.quantity)
    end
    subtotal
  end

end
