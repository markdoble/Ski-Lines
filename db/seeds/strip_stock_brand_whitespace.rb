stockproducts = Stockproduct.all
# for each stock product
stockproducts.each do |f|
  f.brand.strip
end
