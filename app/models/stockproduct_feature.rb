class StockproductFeature < ActiveRecord::Base
  belongs_to :stockproduct
  belongs_to :feature
end
