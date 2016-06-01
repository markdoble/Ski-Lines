class ProductCategory < ActiveRecord::Base
  belongs_to :product
  has_many :product_subcategories
  accepts_nested_attributes_for :product_subcategories, :allow_destroy => true, :reject_if => lambda { |a| a[:subcategory].blank? }
end
