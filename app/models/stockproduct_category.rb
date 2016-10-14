class StockproductCategory < ActiveRecord::Base
  # Associations needed to implement the stockproduct_categories join relationships
  belongs_to :stockproduct
  belongs_to :category
end
