module Admin::StockproductsHelper

  def build_stockproductfotos(stockproduct)
    times_build = 6 - stockproduct.stockproductfotos.count
    times_build.times {@stockproduct.stockproductfotos.build}
  end

end
