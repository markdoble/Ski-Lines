class Order < ActiveRecord::Base

# Associations:
  has_many :merchant_orders, :class_name => 'MerchantOrder'
  has_many :users, :through => :merchant_orders
  accepts_nested_attributes_for :merchant_orders

  has_many :order_units, :class_name => 'OrderUnits'
  has_many :units, :through => :order_units
  accepts_nested_attributes_for :order_units, :reject_if => proc { |attributes| attributes['quantity'].to_i.zero? }

  has_and_belongs_to_many :products

# Validations:


  #email/name
  validates_format_of :cust_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :cust_email, confirmation: true
  validates :cust_email, :presence => {:message => 'Please fill out your email address.'}
  validates :cust_last_name, :presence => {:message => 'Please fill out your last name.'}
  validates :cust_first_name, :presence => {:message => 'Please fill out your first name.'}

  # address
  validates :postal_zip, :presence => {:message => 'Please fill out your postal/zip code.'}
  validates :country, :presence => {:message => 'Please fill out your country.'}
  validates :prov_state, :presence => {:message => 'Please fill out your province/state.'}
  validates :street_address, :presence => {:message => 'Please fill out your street address.'}
  validates :city, :presence => {:message => 'Please fill out your city.'}

  # scopes
  scope :verified, -> { where(success: true) }
end
