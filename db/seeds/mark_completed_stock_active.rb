# when stock has all features necessary for listing, mark it as active
stockproducts = Stockproduct.all
# for each stock product
stockproducts.each do |f|
  if f.categories.blank?
    next
  elsif f.stockphoto.blank?
    next
  elsif f.stockunits.blank?
    next
  elsif f.name.blank?
    next
  elsif f.brand.blank?
    next
  elsif f.description.blank?
    next
  else
    f.update_attribute(:ca_status, true)
    f.update_attribute(:us_status, true)
  end
end
