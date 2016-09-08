module Admin::OrderHelper

  def merchant_order_units(order)
      merchant_order_units = []
      order.order_units.where.not(quantity: 0).each do |p|
        unless p.unit.nil?
          if p.unit.product.user.id == current_user.id
            merchant_order_units << p
          else
            next
          end
        end
      end
    @merchant_order_units = merchant_order_units
  end

  def order_status_indicator(f)
    if f.merchant_orders.where(user_id: current_user.id).map{|e| e.order_status}.include? false
      status = "Action Required"
    else
      status ="Order Filled"
    end
    status
  end

  def merchant_order_products(order)
    merchant_order_product_array = []
    order.order_units.where.not(quantity: 0).each do |p|
      unless p.unit.nil?
        if p.unit.product.user.id == current_user.id
          merchant_order_product_array << p.unit.product
        else
          next
        end
      end
    end
  @merchant_order_products = merchant_order_product_array.uniq
  end

  def merchant_order_subtotal(f)
    subtotal = 0
    f.order_units.where.not(quantity: 0).each do |p|
      next unless p.unit.product.user.id == current_user.id
      subtotal += p.sub_total
    end
    subtotal
  end

  def merchant_order_shipping(f)
    shipping = 0
    f.order_units.where.not(quantity: 0).each do |p|
      next unless p.unit.product.user.id == current_user.id
      shipping += p.shipping_charged
    end
    shipping
  end

  def merchant_order_tax(f)
    tax = 0
    f.order_units.where.not(quantity: 0).each do |p|
      next unless p.unit.product.user.id == current_user.id
      tax += p.sales_tax_charged
    end
    tax
  end

  def merchant_order_total(f)
    total = 0
    f.order_units.where.not(quantity: 0).each do |p|
      next unless p.unit.product.user.id == current_user.id
      total += (p.sub_total+p.sales_tax_charged+p.shipping_charged)
    end
    total
  end

  def flag_selector_based_on_currency(currency)
    case currency
    when "CAD"
      "ca"
    when "USD"
      "us"
    end
  end


end
