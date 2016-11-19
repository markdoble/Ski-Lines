class Stockproduct < ActiveRecord::Base
  has_one :stockphoto, dependent: :destroy
  accepts_nested_attributes_for :stockphoto, :allow_destroy => true, :reject_if => lambda { |a| a[:photo].blank? }

  has_many :stockproductfotos, dependent: :destroy
  accepts_nested_attributes_for :stockproductfotos, :allow_destroy => true, :reject_if => lambda { |a| a[:foto].blank? }

  # Associations needed to implement the stockproduct_categories join relationships
  has_many :stockproduct_categories
  has_many :categories, through: :stockproduct_categories

  # Associations needed for the units
  has_many :stockunits,
       inverse_of: :stockproduct, dependent: :destroy
  accepts_nested_attributes_for :stockunits, :allow_destroy => true, :reject_if => lambda { |a| a[:quantity].blank? }

  scope :category_specific, -> (category_id) { joins(:stockproduct_categories).where("stockproduct_categories.category_id IN (?)", category_id) }
  scope :search, ->(query) { where('name ilike ? OR brand ilike ? OR sku ilike ?', "%#{query}%", "%#{query}%", "%#{query}%") }

  # association set up for listing product features
  has_many :stockproduct_features, dependent: :destroy
  has_many :features, through: :stockproduct_features

  validates :name, :presence => {:message => 'cannot be blank.'}
  #validates :description, :presence => {:message => 'cannot be blank.'}
  #validates :price, :presence => {:message => 'cannot be blank.'}
  #validates :currency, :presence => {:message => 'cannot be blank.'}
  #validates :shipping_charge, :presence => {:message => 'cannot be blank.'}
  # validates :photo, :presence => {:message => 'cannot be blank.'}
  validates_length_of :name, :minimum => 0, :maximum => 60
  validates_length_of :brand, :minimum => 0, :maximum => 40
  validates_length_of :description, :minimum => 0, :maximum => 1000

end
