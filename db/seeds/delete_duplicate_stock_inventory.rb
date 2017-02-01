# remove duplicate sizes from stockproduct inventory
stockproducts = Stockproduct.all
# for each stock product
stockproducts.each do |f|
  # create empty array to fill with records already checked
  seen = []
  # for each stockunit
  f.stockunits.each do |ff|
    # if that unit has been added to the array already, delete it
    if seen.include? [ff.size, ff.colour]
      ff.delete
    # else, add it to the array of seen inventory
    else
      seen << [ff.size, ff.colour]
    end
  end
end
