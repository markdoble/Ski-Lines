class ProductStockphoto < ActiveRecord::Base
  belongs_to :product
  belongs_to :stockphoto
end
