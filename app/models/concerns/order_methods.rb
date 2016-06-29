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



    # Instance methods are not contained in the module: use on an instance of the class, such as @order
    def calculate_order_amount(order)
      order_units_array = []
      order.order_units.where.not(quantity: 0).each do |f|
        order_units_array << f.unit
      end
      test_amount = 0
      order.merchant_orders.each do |f|
        tax_rate_calc(f)
        international_shipping_factor(f)
        order_units_array.each do |ff|
          if f.product_id == ff.product_id
            test_amount += (ff.product.price + (ff.product.shipping_charge*shipping_factor))*tax_rate
          else
            next
          end
        end
      end
    end

    def international_shipping_factor(f)
      case f.order.country
      when "United States of America"
        shipping_factor = 1.5
      else
        shipping_factor = 1
      end
    end

    def tax_rate_calc(f)
      merchant_location = f.user.state_prov
      if f.shipping_method == "In Store Pick-Up"
        customer_location = f.user.state_prov
        customer_country = f.user.country
      else
        customer_location = f.order.prov_state
        customer_country = f.order.country
      end
      if ["New Brunswick", "Newfoundland and Labrador", "Nova Scotia", "Ontario", "Prince Edward Island", 'Northwest Territories', 'Nunavut', 'Yukon'].include? customer_location
        if customer_location == "New Brunswick" then tax_rate = 0.13
        elsif customer_location == "Newfoundland and Labrador" then tax_rate = 0.13
        elsif customer_location == "Nova Scotia" then tax_rate = 0.15
        elsif customer_location == "Ontario" then tax_rate = 0.13
        elsif customer_location == "Prince Edward Island" then tax_rate = 0.14
        elsif ['Northwest Territories', 'Nunavut', 'Yukon'].includes? customer_location then tax_rate = 0.05
        end
      elsif customer_location == merchant_location
        if customer_location == "Alberta" then tax_rate = 0.05
        elsif customer_location == "British Columbia" then tax_rate = 0.12
        elsif customer_location == "Manitoba" then tax_rate = 0.13
        elsif customer_location == "Quebec" then tax_rate = 0.1475
        elsif customer_location == "Saskatchewan" then tax_rate = 0.1
        end
      elsif customer_location != merchant_location
        if customer_location == "Alberta" then tax_rate = 0.05
        elsif customer_location == "British Columbia" then tax_rate = 0.05
        elsif customer_location == "Manitoba" then tax_rate = 0.05
        elsif customer_location == "Quebec" then tax_rate = 0.05
        elsif customer_location == "Saskatchewan" then tax_rate = 0.05
        end
      elsif customer_country != "Canada" then tax_rate = 0
      end
      tax_rate
    end

end
