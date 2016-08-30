class ProductCategory < ActiveRecord::Base
  # Associations needed to implement the product_categories join relationships
  belongs_to :product
  belongs_to :category
end
