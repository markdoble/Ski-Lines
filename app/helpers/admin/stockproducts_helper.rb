module Admin::StockproductsHelper

  def build_stockproductfotos(stockproduct)
    times_build = 6 - stockproduct.stockproductfotos.count
    times_build.times {@stockproduct.stockproductfotos.build}
  end

  def product_created_from_stockproduct(stockphoto_id)
    if ProductStockphoto.where(stockphoto_id: stockphoto_id).empty?
      true
    else
      false
    end
  end

end
