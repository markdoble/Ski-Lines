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

  def order_status_indicator(f)
    if f.merchant_orders.where(user_id: current_user.id).map{|e| e.order_status}.include? false
      status = "Action Required"
    else
      status ="Order Filled"
    end
    status
  end

end
