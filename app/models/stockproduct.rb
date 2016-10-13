class Stockproduct < ActiveRecord::Base
  has_one :stockphoto, dependent: :destroy
  accepts_nested_attributes_for :stockphoto, :allow_destroy => true, :reject_if => lambda { |a| a[:photo].blank? }

  has_many :stockproductfotos, dependent: :destroy 
  accepts_nested_attributes_for :stockproductfotos, :allow_destroy => true, :reject_if => lambda { |a| a[:foto].blank? }

  scope :search, ->(query) { where('name ilike :q', q: "%#{query}%") }
end