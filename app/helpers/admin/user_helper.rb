module Admin::UserHelper

  def usd_value(user)
    user = User.find_by_id(user)
    usd_value = 0
    user.products.where(status: true).each do |f|
      f.units.each do |ff|
        usd_value += ff.quantity*f.usd_price
      end
    end
    number_to_currency(usd_value, unit: "$")
  end

  def cad_value(user)
    user = User.find_by_id(user)
    cad_value = 0
    user.products.where(status: true).each do |f|
      f.units.each do |ff|
        cad_value += ff.quantity*f.cad_price
      end
    end
    number_to_currency(cad_value, unit: "$")
  end

end
