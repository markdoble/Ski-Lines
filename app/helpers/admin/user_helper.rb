module Admin::UserHelper

  def usd_value(user)
    user = User.find_by_id(user)
    usd_value = 0
    user.products.where(status: true).each do |f|
      usd_value += f.usd_price
    end
    number_to_currency(usd_value, unit: "$")
  end

  def cad_value(user)
    user = User.find_by_id(user)
    cad_value = 0
    user.products.where(status: true).each do |f|
      cad_value += f.cad_price
    end
    number_to_currency(cad_value, unit: "$")
  end

end
