class Product < ActiveRecord::Base
  # Associations needed for the users and orders
  belongs_to :user
  belongs_to :merchant_order
  has_and_belongs_to_many :orders

  # Associations needed to implement the product_categories join relationships
  has_many :product_categories
  has_many :categories, through: :product_categories
  accepts_nested_attributes_for :categories

  has_many :countries, through: :permitted_destinations
  has_many :permitted_destinations

  # Associations needed for the units
  has_many :units,
       inverse_of: :product, dependent: :destroy
  accepts_nested_attributes_for :units, :allow_destroy => true, :reject_if => lambda { |a| a[:quantity].blank? }

  # Associations needed for the photos
  has_many :productfotos
  accepts_nested_attributes_for :productfotos, :allow_destroy => true, :reject_if => lambda { |a| a[:foto].blank? }
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

  # Define the validations needed for the product model
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  #validates :price, numericality: true
  #validates :shipping_charge, numericality: true

  validates_numericality_of :usd_price, :allow_nil => true
  validates_numericality_of :cad_price, :allow_nil => true
  validates_numericality_of :cad_domestic_shipping, :allow_nil => true
  validates_numericality_of :cad_foreign_shipping, :allow_nil => true
  validates_numericality_of :usd_domestic_shipping, :allow_nil => true
  validates_numericality_of :usd_foreign_shipping, :allow_nil => true
  
  validates :name, :presence => {:message => 'cannot be blank.'}
  #validates :description, :presence => {:message => 'cannot be blank.'}
  #validates :price, :presence => {:message => 'cannot be blank.'}
  #validates :currency, :presence => {:message => 'cannot be blank.'}
  #validates :shipping_charge, :presence => {:message => 'cannot be blank.'}
  # validates :photo, :presence => {:message => 'cannot be blank.'}
  validates_length_of :name, :minimum => 0, :maximum => 40
  validates_length_of :description, :minimum => 0, :maximum => 1000

  # Define the scopes to be used
  scope :search, ->(query) { where('name ilike :q', q: "%#{query}%") }
  scope :user_products, -> { where(user_id: current_user.id) }
  scope :index_products, -> { limit(4) }
  scope :active_products, -> { includes(:units).where("units.quantity > ?", 0).references(:units).where(:status => "TRUE") }
  scope :query, ->(query) { where('name ilike :q', q: "%#{query}%") }
  scope :category_specific, -> (category_id) { joins(:product_categories).where("product_categories.category_id IN (?)", category_id) }

  scope :country_specific, -> (site_country) { where("('ca' = ? AND cad_price > 0) OR ('us' = ? AND usd_price > 0)", site_country, site_country) }

  # Will return the correct value depending on the site country specified
  # If a product does not have a value in the given currency, the value of 0 will be returned
  def currency_price(site_country)
    # Execute the case statements for the country
    case site_country
      when "ca"
        self[:cad_price].blank? ? 0 : self[:cad_price]
      when "us"
        self[:usd_price].blank? ? 0 : self[:usd_price]
      else
        0
    end
  end

  # Will return the correct value depending on the site country specified
  # If a product does not have a value in the given currency, the value of 0 will be returned
  def currency_domestic_shipping(site_country)
    # Execute the case statements for the country
    case site_country
      when "ca"
        self[:cad_domestic_shipping].blank? ? 0 : self[:cad_domestic_shipping]
      when "us"
        self[:usd_domestic_shipping].blank? ? 0 : self[:usd_domestic_shipping]
      else
        0
    end
  end

  # Will return the correct value depending on the site country specified
  # If a product does not have a value in the given currency, the value of 0 will be returned
  def currency_foreign_shipping(site_country)
    # Execute the case statements for the country
    case site_country
      when "ca"
        self[:cad_foreign_shipping].blank? ? 0 : self[:cad_foreign_shipping]
      when "us"
        self[:usd_foreign_shipping].blank? ? 0 : self[:usd_foreign_shipping]
      else
        0
    end
  end

end
