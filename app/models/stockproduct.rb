class Stockproduct < ActiveRecord::Base
  has_one :stockphoto, dependent: :destroy
  accepts_nested_attributes_for :stockphoto, :allow_destroy => true, :reject_if => lambda { |a| a[:photo].blank? }

  has_many :stockproductfotos, dependent: :destroy
  accepts_nested_attributes_for :stockproductfotos, :allow_destroy => true, :reject_if => lambda { |a| a[:foto].blank? }

  # Associations needed to implement the stockproduct_categories join relationships
  has_many :stockproduct_categories
  has_many :categories, through: :stockproduct_categories

  scope :search, ->(query) { where('name ilike :q', q: "%#{query}%") }
end
