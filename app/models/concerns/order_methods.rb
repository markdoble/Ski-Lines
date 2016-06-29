module OrderMethods
  extend ActiveSupport::Concern

  included do
    # Extend Associations:
    has_many :merchant_orders, :class_name => 'MerchantOrder'
    has_many :users, :through => :merchant_orders
    accepts_nested_attributes_for :merchant_orders
    has_many :order_units, :class_name => 'OrderUnits'
    has_many :units, :through => :order_units
    accepts_nested_attributes_for :order_units
    has_and_belongs_to_many :products
  end




  module ClassMethods
  #These are class methods to be called on an instance of the class, ex: Order.example(order)




  end
    # Instance methods are not contained in the module. Use on an instance of the class, such as calculate_order_amount(order)

    

end
