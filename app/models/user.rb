class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :validatable, :confirmable, :lockable, :timeoutable, :omniauthable, :registerable, :recoverable
  devise :database_authenticatable, :rememberable, :trackable, :registerable
  has_many :products, dependent: :destroy

  has_many :merchant_orders, :class_name => 'MerchantOrder'
  has_many :orders, :through => :merchant_orders

  # enables user-user messaging. Required by mailboxer
  acts_as_messageable

  # validates_uniqueness_of :slug, {message: "Your store url conflicts with another url in our system. Please email mark@ski-lines.com for a solution."}
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_uniqueness_of :email, {message: "The email address provided conflicts with another address in our system. Please ensure you have entered the correct email address."}
  # need to change this to a after_create method to remove unecessary elements of url, rather than preventing creation
  #validate :merchant_url_format

  # validations needed:
  # if merchant_rep creating account, set merchant to true, and other roles to false.

  # required mailboxer definitions
  def mailboxer_name
    # merchants and users do not use the same field or their name, we must check for user type
    if self.merchant?
      self.merchant_name
    else
      self.contact_name
    end
  end
  def mailboxer_email(object)
    self.email
  end

  # defines if the user has access to the mailbox
  def has_mailbox_access
    # we only want to allow merchants and general users
    # merchant = merchant
    # general user = not merchant, not admin, not article_publisher, not merchant_rep
    if self.merchant || (!self.admin && !self.article_publisher && !self.merchant_rep && !self.merchant)
      true
    else
      false
    end
  end

  def merchant_url_format
    if self.merchant_url[0...4] == "http" or self.merchant_url[0...3] == "www" or self.merchant_url[0,1] == "."
      errors.add(:base, "Do not include http or www at the start of your website url")
    end
  end
  scope :with_active_products, -> { joins(:products).where(products: { status: true }) }
  scope :merchants, -> { where(merchant: true).order(id: :desc).where.not(admin: true) }
end
