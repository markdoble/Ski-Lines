module Admin::AllOrdersHelper

  def order_products(order)
    product_array = []
    order.order_units.where.not(quantity: 0).each do |u|
      unless u.unit.nil?
      product_array << u.unit.product.name
      end
    end
    simple_format(product_array.join('<br />'))
  end

  def order_unit_size(order)
    unit_size_array = []
      order.order_units.where.not(quantity: 0).each do |u|
        unless u.unit.nil?
          if u.unit.size == ""
            unit_size_array << "N/A"
          else
          unit_size_array << u.unit.size
          end
        end
      end
      simple_format(unit_size_array.join('<br />'))
  end

  def order_unit_qty(order)
    unit_qty_array = []
      order.order_units.where.not(quantity: 0).each do |u|
        unless u.unit.nil?
        unit_qty_array << u.quantity
        end
      end
      simple_format(unit_qty_array.join('<br />'))
  end

  def total_merchants
    User.where(merchant: true).where.not(admin: true).count
  end

  def total_number_of_products
    Product.all.count
  end

  def all_total_value
    product_value = []
    Product.all.each do |p|
      p.units.each do |u|
        product_value << (u.product.shipping_charge*u.quantity)+(u.quantity*u.product.price)
      end
    end
      product_value.inject(0){|sum,x| sum + x }
  end

  def total_active_value
    product_active_value = []
    Product.where(status: true).each do |p|
      p.units.each do |u|
        product_active_value << (u.product.shipping_charge*u.quantity)+(u.quantity*u.product.price)
      end
    end
      product_active_value.inject(0){|sum,x| sum + x }
  end

  def total_sl_value
    product_value = []
    Product.all.each do |p|
      p.units.each do |u|
        product_value << ((u.product.shipping_charge*u.quantity)+(u.quantity*u.product.price))*0.075
      end
    end
    product_value.inject(0){|sum,x| sum + x }
  end

  def total_sl_active_value
    product_active_value = []
    Product.where(status: true).each do |p|
      p.units.each do |u|
        product_active_value << ((u.product.shipping_charge*u.quantity)+(u.quantity*u.product.price))*0.075
      end
    end
    product_active_value.inject(0){|sum,x| sum + x }
  end

  def total_value(m)
    unit_price_arr = []
    m.products.where(status: true).each do |p|
      p.units.each do |u|
        unit_price_arr << (u.product.shipping_charge*u.quantity)+(u.quantity*u.product.price)
      end
    end
    unit_price_arr.inject(0){|sum,x| sum + x }
  end

  def product_value(m)
    unit_price_arr = []
    m.products.where(status: true).each do |p|
      p.units.each do |u|
        unit_price_arr << u.product.price*u.quantity
      end
    end
    unit_price_arr.inject(0){|sum,x| sum + x }
  end

  def shipping_value(m)
    unit_price_arr = []
    m.products.where(status: true).each do |p|
      p.units.each do |u|
        unit_price_arr << u.product.shipping_charge*u.quantity
      end
    end
    unit_price_arr.inject(0){|sum,x| sum + x }
  end

  def subtotal(f)
    subtotal = 0
    if !f.amount.blank? && !f.sales_tax.blank? && !f.shipping.blank?
    subtotal = f.amount - f.sales_tax - f.shipping
    end
    subtotal 
  end

end
