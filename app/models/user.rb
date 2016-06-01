class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :validatable, :confirmable, :lockable, :timeoutable, :omniauthable, :registerable, :recoverable
  devise :database_authenticatable, :rememberable, :trackable, :registerable
  has_many :products, dependent: :destroy

  has_many :merchant_orders, :class_name => 'MerchantOrder'
  has_many :orders, :through => :merchant_orders

  validates :shipping_cost, numericality: true
  validates_uniqueness_of :slug, {message: "Your store url conflicts with another url in our system. Please email mark@ski-lines.com for a solution."}
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_uniqueness_of :email, {message: "The email address provided conflicts with another address in our system. Please ensure you have entered the correct email address."}
  validate :merchant_url_format


  def merchant_url_format
    if self.merchant_url[0...4] == "http" or self.merchant_url[0...3] == "www" or self.merchant_url[0,1] == "."
      errors.add(:base, "Do not include http or www at the start of your website url")
    end

  end
  scope :with_active_products, -> { joins(:products).where(products: { status: true }) }

  scope :merchants, -> { where(merchant: true).order(id: :desc).where.not(admin: true) }


end
