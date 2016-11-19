class Feature < ActiveRecord::Base
  has_many :product_features
  has_many :products, through: :product_features

  has_many :stockproduct_features
  has_many :stockproducts, through: :stockproduct_features
end
