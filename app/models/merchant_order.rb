class MerchantOrder < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  has_many :products
  accepts_nested_attributes_for :products, :allow_destroy => true, :reject_if => lambda { |a| a[:product_id].blank? }
end
