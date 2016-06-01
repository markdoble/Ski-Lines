module Admin::ProductsHelper
    def admin_tax_rate_calc(order)
      order.users.where(id: current_user.id).each do |u|
          if ["New Brunswick", "Newfoundland and Labrador", "Nova Scotia", "Ontario", "Prince Edward Island", 'Northwest Territories', 'Nunavut', 'Yukon'].include? order.prov_state
              if order.prov_state == "New Brunswick" then @tax_rate = 0.13
              elsif order.prov_state == "Newfoundland and Labrador" then @tax_rate = 0.13
              elsif order.prov_state == "Nova Scotia" then @tax_rate = 0.15
              elsif order.prov_state == "Ontario" then @tax_rate = 0.13
              elsif order.prov_state == "Prince Edward Island" then @tax_rate = 0.14
              elsif ['Northwest Territories', 'Nunavut', 'Yukon'].includes? order.prov_state then @tax_rate = 0.05
              end
            elsif order.prov_state == u.state_prov 
              if order.prov_state == "Alberta" then @tax_rate = 0.05
              elsif order.prov_state == "British Columbia" then @tax_rate = 0.12
              elsif order.prov_state == "Manitoba" then @tax_rate = 0.13
              elsif order.prov_state == "Quebec" then @tax_rate = 0.1475
              elsif order.prov_state == "Saskatchewan" then @tax_rate = 0.1
              end
            elsif order.prov_state != u.state_prov 
              if order.prov_state == "Alberta" then @tax_rate = 0.05
              elsif order.prov_state == "British Columbia" then @tax_rate = 0.05
              elsif order.prov_state == "Manitoba" then @tax_rate = 0.05
              elsif order.prov_state == "Quebec" then @tax_rate = 0.05
              elsif order.prov_state == "Saskatchewan" then @tax_rate = 0.05
              end
            elsif order.country != "Canada" then @tax_rate = 0
          end
       end
        
      @tax_rate
    end
    
    
    def build_productfotos(product)
      times_build = 6 - product.productfotos.count
      times_build.times {@product.productfotos.build} 
    end
    
   
    
    
end
  