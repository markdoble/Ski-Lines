module Admin::ReturnHelper

  def flag_selector_based_on_currency(currency)
    case currency
    when "CAD"
      "ca"
    when "USD"
      "us"
    end
  end

  def refund_total(return_request)
    if [return_request.suggested_sub_total, return_request.suggested_sales_tax, return_request.suggested_shipping_charge].all? { |check| check.nil? || check == 0.00  }
      sub_total = return_request.default_sub_total+return_request.default_sales_tax+return_request.default_shipping_charge
    else
      sub_total = return_request.suggested_sub_total+return_request.suggested_sales_tax+return_request.suggested_shipping_charge
    end
    sub_total
  end

  def refund_status_indicator(f)
    case f
    when false
      "Pending"
    when true
      "Complete"
    end
  end

end
