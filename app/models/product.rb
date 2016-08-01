class Product < ActiveRecord::Base
# model associations
  belongs_to :user
  belongs_to :merchant_order
  has_many :productfotos
  accepts_nested_attributes_for :productfotos, :allow_destroy => true, :reject_if => lambda { |a| a[:foto].blank? }
  has_many :product_categories
  accepts_nested_attributes_for :product_categories
  has_and_belongs_to_many :orders
  has_many :units,
       inverse_of: :product, dependent: :destroy
  accepts_nested_attributes_for :units, :allow_destroy => true, :reject_if => lambda { |a| a[:quantity].blank? }
  has_attached_file :photo,
                      :styles => { :medium => "300x300>",
                                   :thumb => "100x100>",
                                   :large => "500x500" },
                      :storage => :s3,
                      :s3_protocol => :https,
                      :s3_credentials => {
                        :bucket => ENV['S3_BUCKET'],
                        :access_key_id => ENV['AWS_KEY_ID'],
                        :secret_access_key => ENV['AWS_ACCESS_KEY']

                      }

# validations
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates :price, numericality: true
  validates :shipping_charge, numericality: true
  validates :name, :presence => {:message => 'cannot be blank.'}
  validates :description, :presence => {:message => 'cannot be blank.'}
  validates :price, :presence => {:message => 'cannot be blank.'}
  validates :currency, :presence => {:message => 'cannot be blank.'}
  validates :product_category, :presence => {:message => 'cannot be blank.'}
  validates :product_subcategory, :presence => {:message => 'cannot be blank.'}
  validates :shipping_charge, :presence => {:message => 'cannot be blank.'}
  validates :photo, :presence => {:message => 'cannot be blank.'}
  validates_length_of :name, :minimum => 3, :maximum => 35


# Scopes
  scope :search, ->(query) { where('name ilike :q', q: "%#{query}%") }
  scope :user_products, -> { where(user_id: current_user.id) }
  scope :hard_goods, -> { where(:product_category => ["Boots", "Skis", "Poles", "Roller Skis"]) }
  scope :clothing, -> { where(:product_category => ["Clothing Men", "Clothing Kids", "Clothing Women", "Unisex Clothing Accessories"]) }
  scope :waxing, -> { where(product_category: "Waxing") }
  scope :accessories, -> { where(:product_category => ["Accessories"]) }
  scope :index_products, -> { limit(4) }
  scope :active_products, -> { includes(:units).where("units.quantity > ?", 0).references(:units).where(:status => "TRUE") }

  # Clothing Page Filters
  scope :category, -> (category) { where(product_category: category) }
  scope :sub_category, -> (sub_category) { where(product_subcategory: sub_category)  }
  scope :query, ->(query) { where('name ilike :q', q: "%#{query}%") }

  # Hard Goods Page Filter
  scope :sbp, -> (sbp) { where(product_subcategory: sbp) }

  # Accessories Filter
  scope :acc, -> (acc) { where(product_subcategory: acc) }

  # Wax Filter
  scope :wax, -> (wax) { where(product_subcategory: wax) }

  # All Products Page Filter
  scope :allfilter, -> (allfilter) { where(product_subcategory: allfilter) }
end
