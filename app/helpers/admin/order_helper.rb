module Admin::OrderHelper

  def merchant_order_units(order)
    merchant_order_units = []

      order.order_units.where.not(quantity: 0).each do |u|
        unless u.unit.nil?
          if u.unit.product.user.id == current_user.id
            merchant_order_units << u
          else
            next
          end
        end
      end

    merchant_order_units
  end




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


  def admin_shipping_calc(m_o, p)
    if m_o.delivery_method == "In Store Pick-Up"
      shipping_method_factor = 0
    else
      shipping_method_factor = 1
    end

    if m_o.order.country == "Canada"
      shipping_international_factor = 1
    else
      shipping_international_factor = 1.5
    end
    p.unit.product.shipping_charge*p.quantity*shipping_method_factor*shipping_international_factor
  end


  def admin_tax_calc(m_o, p)
    if m_o.delivery_method == "In Store Pick-Up"
      shipping_method_factor = 0
    else
      shipping_method_factor = 1
    end

    if m_o.order.country == "Canada"
      shipping_international_factor = 1
    else
      shipping_international_factor = 1.5
    end
    @taxable_amount = (p.unit.product.price*p.quantity) + (p.unit.product.shipping_charge*shipping_method_factor*shipping_international_factor)

    if m_o.delivery_method == "In Store Pick-Up"
      tax_prov_if_pick_up_in_store = p.unit.product.user.state_prov
    else
      tax_prov_if_pick_up_in_store = m_o.order.prov_state
    end

    if ["New Brunswick", "Newfoundland and Labrador", "Nova Scotia", "Ontario", "Prince Edward Island", 'Northwest Territories', 'Nunavut', 'Yukon'].include? tax_prov_if_pick_up_in_store
        if tax_prov_if_pick_up_in_store == "New Brunswick" then @tax_rate = 0.13
        elsif tax_prov_if_pick_up_in_store == "Newfoundland and Labrador" then @tax_rate = 0.13
        elsif tax_prov_if_pick_up_in_store == "Nova Scotia" then @tax_rate = 0.15
        elsif tax_prov_if_pick_up_in_store == "Ontario" then @tax_rate = 0.13
        elsif tax_prov_if_pick_up_in_store == "Prince Edward Island" then @tax_rate = 0.14
        elsif ['Northwest Territories', 'Nunavut', 'Yukon'].includes? tax_prov_if_pick_up_in_store then @tax_rate = 0.05
        end
      elsif tax_prov_if_pick_up_in_store == p.unit.product.user.state_prov
        if tax_prov_if_pick_up_in_store == "Alberta" then @tax_rate = 0.05
        elsif tax_prov_if_pick_up_in_store == "British Columbia" then @tax_rate = 0.12
        elsif tax_prov_if_pick_up_in_store == "Manitoba" then @tax_rate = 0.13
        elsif tax_prov_if_pick_up_in_store == "Quebec" then @tax_rate = 0.1475
        elsif tax_prov_if_pick_up_in_store == "Saskatchewan" then @tax_rate = 0.1
        end
      elsif tax_prov_if_pick_up_in_store != p.unit.product.user.state_prov
        if tax_prov_if_pick_up_in_store == "Alberta" then @tax_rate = 0.05
        elsif tax_prov_if_pick_up_in_store == "British Columbia" then @tax_rate = 0.05
        elsif tax_prov_if_pick_up_in_store == "Manitoba" then @tax_rate = 0.05
        elsif tax_prov_if_pick_up_in_store == "Quebec" then @tax_rate = 0.05
        elsif tax_prov_if_pick_up_in_store == "Saskatchewan" then @tax_rate = 0.05
        end
      elsif ["Alberta", "British Columbia", "Manitoba", "Quebec", "Saskatchewan", "New Brunswick", "Newfoundland and Labrador", "Nova Scotia", "Ontario", "Prince Edward Island", 'Northwest Territories', 'Nunavut', 'Yukon'].exclude? tax_prov_if_pick_up_in_store then @tax_rate = 0
    end
    @taxable_amount*@tax_rate
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

  def total_value(m)
    unit_price_arr = []

    m.products.where(status: true).each do |p|
      p.units.each do |u|
        unit_price_arr << (u.product.shipping_charge*u.quantity)+(u.quantity*u.product.price)
      end
    end

    unit_price_arr.inject(0){|sum,x| sum + x }
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


end
