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
 #These are class methods

    def self.create_merchant_order_units(order)
      # make array of order units and find its:
        # shipping method
        # shipping cost
        # tax rate applied to the particular unit
        # total cost of that unit (sum of product price, shipping cost, tax )
      # add up total cost for all units
      order_units_array = []
      order.order_units.where.not(quantity: 0).each do |f|
        order_units_array << f.unit
      end

      order_units_array.each do |f|
        tax_rate += 0
        per_product_tax(order)
        (f.unit.product.shipping_charge + f.unit.product.price)*(1 + tax_rate)
      end

    end


  end



  # Instance methods are not contained in the module: use on an instance of the class, such as @order
    def per_product_tax(order)
      if ["New Brunswick", "Newfoundland and Labrador", "Nova Scotia", "Ontario", "Prince Edward Island", 'Northwest Territories', 'Nunavut', 'Yukon'].include? order.prov_state
          if order.prov_state == "New Brunswick" then @tax_rate = 0.13
          elsif order.prov_state == "Newfoundland and Labrador" then @tax_rate = 0.13
          elsif order.prov_state == "Nova Scotia" then @tax_rate = 0.15
          elsif order.prov_state == "Ontario" then @tax_rate = 0.13
          elsif order.prov_state == "Prince Edward Island" then @tax_rate = 0.14
          elsif ['Northwest Territories', 'Nunavut', 'Yukon'].includes? order.prov_state then @tax_rate = 0.05
          end
      elsif order.prov_state == user.state_prov
        if order.prov_state == "Alberta" then @tax_rate = 0.05
        elsif order.prov_state == "British Columbia" then @tax_rate = 0.12
        elsif order.prov_state == "Manitoba" then @tax_rate = 0.13
        elsif order.prov_state == "Quebec" then @tax_rate = 0.1475
        elsif order.prov_state == "Saskatchewan" then @tax_rate = 0.1
        end
      elsif order.prov_state != user.state_prov
        if order.prov_state == "Alberta" then @tax_rate = 0.05
        elsif order.prov_state == "British Columbia" then @tax_rate = 0.05
        elsif order.prov_state == "Manitoba" then @tax_rate = 0.05
        elsif order.prov_state == "Quebec" then @tax_rate = 0.05
        elsif order.prov_state == "Saskatchewan" then @tax_rate = 0.05
        end
      elsif order.country != "Canada" then @tax_rate = 0
      end
      @tax_rate
    end

    def tax_rate_calc(order, user)
          if ["New Brunswick", "Newfoundland and Labrador", "Nova Scotia", "Ontario", "Prince Edward Island", 'Northwest Territories', 'Nunavut', 'Yukon'].include? order.prov_state
              if order.prov_state == "New Brunswick" then @tax_rate = 0.13
              elsif order.prov_state == "Newfoundland and Labrador" then @tax_rate = 0.13
              elsif order.prov_state == "Nova Scotia" then @tax_rate = 0.15
              elsif order.prov_state == "Ontario" then @tax_rate = 0.13
              elsif order.prov_state == "Prince Edward Island" then @tax_rate = 0.14
              elsif ['Northwest Territories', 'Nunavut', 'Yukon'].includes? order.prov_state then @tax_rate = 0.05
              end
          elsif order.prov_state == user.state_prov
            if order.prov_state == "Alberta" then @tax_rate = 0.05
            elsif order.prov_state == "British Columbia" then @tax_rate = 0.12
            elsif order.prov_state == "Manitoba" then @tax_rate = 0.13
            elsif order.prov_state == "Quebec" then @tax_rate = 0.1475
            elsif order.prov_state == "Saskatchewan" then @tax_rate = 0.1
            end
          elsif order.prov_state != user.state_prov
            if order.prov_state == "Alberta" then @tax_rate = 0.05
            elsif order.prov_state == "British Columbia" then @tax_rate = 0.05
            elsif order.prov_state == "Manitoba" then @tax_rate = 0.05
            elsif order.prov_state == "Quebec" then @tax_rate = 0.05
            elsif order.prov_state == "Saskatchewan" then @tax_rate = 0.05
            end
          elsif order.country != "Canada" then @tax_rate = 0
          end
          @tax_rate
    end





end
