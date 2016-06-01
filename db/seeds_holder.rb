

# Seed data for categories (sample layout)
params = {:product_categories => [
        { :category => "Skis", :product_subcategories_attributes => 
                                                      [ {:subcategory => "Skate Skis Performance"},
                                                        {:subcategory => "Skate Skis Racing"},
                                                        {:subcategory => "Skate Skis Entry Level"},
                                                        {:subcategory => "Classic Touring Skis"},
                                                        {:subcategory => "Classic Racing Skis"},
                                                        {:subcategory => "Classic Performance Skis"},
                                                        {:subcategory => "Combi Skis"},
                                                        {:subcategory => "Kids Skis"}]
        },
        {:category => "Boots", :product_subcategories_attributes => 
                                                      [ {:subcategory => "Skate Racing Boots"},
                                                        {:subcategory => "Skate Performance Boots"},
                                                        {:subcategory => "Skate Entry Level Boots"},
                                                        {:subcategory => "Classic Touring Boots"},
                                                        {:subcategory => "Classic Performance Boots"},
                                                        {:subcategory => "Classic Racing Boots"},
                                                        {:subcategory => "Combi Boots"},
                                                        {:subcategory => "Kids Boots"}]
                
        },
        { :category => "Poles", :product_subcategories_attributes => 
                                                      [ {:subcategory => "Racing Poles"},
                                                        {:subcategory => "Touring Poles"},
                                                        {:subcategory => "Performance Poles"}]
        },
       
       
        { :category => "Clothing Men", :product_subcategories_attributes => 
                                                      [ {:subcategory => "Training Jacket"},
                                                        {:subcategory => "Training Pants"},
                                                        {:subcategory => "Training Top"},
                                                        {:subcategory => "Parka"},
                                                        {:subcategory => "Toques"},
                                                        {:subcategory => "Socks"},
                                                        {:subcategory => "Gloves"},
                                                        {:subcategory => "Long Underwear"},
                                                        {:subcategory => "Underwear"},
                                                        {:subcategory => "Tights"}]
        },
        { :category => "Clothing Women", :product_subcategories_attributes => 
                                                      [ {:subcategory => "Training Jacket"},
                                                        {:subcategory => "Training Pants"},
                                                        {:subcategory => "Training Top"},
                                                        {:subcategory => "Parka"},
                                                        {:subcategory => "Toques"},
                                                        {:subcategory => "Socks"},
                                                        {:subcategory => "Gloves"},
                                                        {:subcategory => "Long Underwear"},
                                                        {:subcategory => "Underwear"},
                                                        {:subcategory => "Tights"}]
        },
        { :category => "Unisex Clothing Accessories", :product_subcategories_attributes => 
                                                      [ {:subcategory => "Gloves"},
                                                        {:subcategory => "Toques"},
                                                        {:subcategory => "Socks"},
                                                        {:subcategory => "Buffs"}]
        },
        { :category => "Clothing Kids", :product_subcategories_attributes => 
                                                      [ {:subcategory => "Training Jacket"},
                                                        {:subcategory => "Training Pants"},
                                                        {:subcategory => "Training Top"},
                                                        {:subcategory => "Parka"},
                                                        {:subcategory => "Socks"},
                                                        {:subcategory => "Toques"},
                                                        {:subcategory => "Gloves"},
                                                        {:subcategory => "Long Underwear"},
                                                        {:subcategory => "Underwear"},
                                                        {:subcategory => "Tights"}]
        },
       
       
       
        { :category => "Waxing", :product_subcategories_attributes => 
                                                      [ {:subcategory => "Glide Wax"},
                                                        {:subcategory => "Grip Wax"},
                                                        {:subcategory => "Waxing Tools"}]
        },
        { :category => "Accessories", :product_subcategories_attributes => 
                                                      [ {:subcategory => "Ski Bag"},
                                                        {:subcategory => "Travel Bag Duffel"},
                                                        {:subcategory => "Travel Bag Backpack"},
                                                        {:subcategory => "Drinkbelt"},
                                                        {:subcategory => "Sports Nutrition"},
                                                        {:subcategory => "Glasses"},
                                                        {:subcategory => "Boot Covers"},
                                                        {:subcategory => "Bindings"}]
        },
        ]}

ProductCategory.create!(params[:product_categories])










# seeding products for testing.



params = {:products => [
        { :name => "Winter Parka", 
          :description => "This is a very warm jacket that will also keep you dry",
          :status => "False",
          :user_id => "1",
          :price => "200.00",
          :currency => "CAD",
          :product_category => "Clothing Men",
          :product_subcategory => "Parka" },
       
        { :name => "One Way Warmup Jacket", 
          :description => "This is a good jacket for training that will also keep you dry",
          :status => "False",
          :user_id => "1",
          :price => "100.00",
          :currency => "CAD",
          :product_category => "Clothing Men",
          :product_subcategory => "Training Jacket" },
        
        { :name => "Salomon Skis", 
          :description => "These are great skis for racing and training. ",
          :status => "False",
          :user_id => "1",
          :price => "450.00",
          :currency => "CAD",
          :product_category => "Skis",
          :product_subcategory => "Skate Skis Racing" },
       
        { :name => "Fischer Classic Skis Waxless", 
          :description => "These skis are good for both training and racing in difficult waxing conditions.",
          :status => "False",
          :user_id => "1",
          :price => "350.00",
          :currency => "CAD",
          :product_category => "Skis",
          :product_subcategory => "Classic Performance Skis" },
       
        { :name => "OneWay Racing Poles", 
          :description => "Maximize stiffness and minimize weight with these new OneWay racing poles.",
          :status => "False",
          :user_id => "1",
          :price => "175.00",
          :currency => "CAD",
          :product_category => "Poles",
          :product_subcategory => "Racing Poles" },
        
        { :name => "Exel Touring Poles", 
          :description => "These poles are good for kicking around in the bush, or taking them out on an adventure. Either way, they have you covered.",
          :status => "False",
          :user_id => "1",
          :price => "99.00",
          :currency => "CAD",
          :product_category => "Poles",
          :product_subcategory => "Touring Poles" },
        
        { :name => "Long Underwear by Craft", 
          :description => "This one-piece long underwear will keep you warm and dry by utilizing its advanced whicking technology.",
          :status => "False",
          :user_id => "1",
          :price => "75.00",
          :currency => "CAD",
          :product_category => "Clothing Women",
          :product_subcategory => "Long Underwear" },
       
        { :name => "Rode Weiss Grip Wax", 
          :description => "Need good grip and fast skis? Who doesn't? With Weiss, you can always rely on great skis.",
          :status => "False",
          :user_id => "1",
          :price => "15.00",
          :currency => "CAD",
          :product_category => "Waxing",
          :product_subcategory => "Grip Wax" },
        
        { :name => "Vauhti Goldfox", 
          :description => "A block of wax for the fastest skis on the race course.",
          :status => "False",
          :user_id => "1",
          :price => "150.00",
          :currency => "CAD",
          :product_category => "Waxing",
          :product_subcategory => "Glide Wax" },
        
        { :name => "Finnwool Socks", 
          :description => "These wool socks will gaurantee your feet are warm and dry.",
          :status => "False",
          :user_id => "1",
          :price => "35.00",
          :currency => "CAD",
          :product_category => "Unisex Clothing Accessories",
          :product_subcategory => "Socks" },
       
        { :name => "Sportful Tights", 
          :description => "These tights are sexy and fast. Perfect for the female athlete.",
          :status => "False",
          :user_id => "1",
          :price => "230.00",
          :currency => "CAD",
          :product_category => "Clothing Women",
          :product_subcategory => "Tights" },
        
        { :name => "Winter Parka", 
          :description => "This is a very warm jacket that will also keep you dry",
          :status => "False",
          :user_id => "1",
          :price => "200.00",
          :currency => "CAD",
          :product_category => "Clothing Men",
          :product_subcategory => "Parka" },
     
        { :name => "One Way Warmup Jacket", 
          :description => "This is a good jacket for training that will also keep you dry",
          :status => "False",
          :user_id => "1",
          :price => "100.00",
          :currency => "CAD",
          :product_category => "Clothing Men",
          :product_subcategory => "Training Jacket" },
      
        { :name => "Salomon Skis", 
          :description => "These are great skis for racing and training. ",
          :status => "False",
          :user_id => "1",
          :price => "450.00",
          :currency => "CAD",
          :product_category => "Skis",
          :product_subcategory => "Skate Skis Racing" },
     
        { :name => "Fischer Classic Skis Waxless", 
          :description => "These skis are good for both training and racing in difficult waxing conditions.",
          :status => "False",
          :user_id => "1",
          :price => "350.00",
          :currency => "CAD",
          :product_category => "Skis",
          :product_subcategory => "Classic Performance Skis" },
     
        { :name => "OneWay Racing Poles", 
          :description => "Maximize stiffness and minimize weight with these new OneWay racing poles.",
          :status => "False",
          :user_id => "1",
          :price => "175.00",
          :currency => "CAD",
          :product_category => "Poles",
          :product_subcategory => "Racing Poles" },
      
        { :name => "Exel Touring Poles", 
          :description => "These poles are good for kicking around in the bush, or taking them out on an adventure. Either way, they have you covered.",
          :status => "False",
          :user_id => "1",
          :price => "99.00",
          :currency => "CAD",
          :product_category => "Poles",
          :product_subcategory => "Touring Poles" },
      
        { :name => "Long Underwear by Craft", 
          :description => "This one-piece long underwear will keep you warm and dry by utilizing its advanced whicking technology.",
          :status => "False",
          :user_id => "1",
          :price => "75.00",
          :currency => "CAD",
          :product_category => "Clothing Women",
          :product_subcategory => "Long Underwear" },
     
        { :name => "Rode Weiss Grip Wax", 
          :description => "Need good grip and fast skis? Who doesn't? With Weiss, you can always rely on great skis.",
          :status => "False",
          :user_id => "1",
          :price => "15.00",
          :currency => "CAD",
          :product_category => "Waxing",
          :product_subcategory => "Grip Wax" },
      
        { :name => "Vauhti Goldfox", 
          :description => "A block of wax for the fastest skis on the race course.",
          :status => "False",
          :user_id => "1",
          :price => "150.00",
          :currency => "CAD",
          :product_category => "Waxing",
          :product_subcategory => "Glide Wax" },
      
        { :name => "Finnwool Socks", 
          :description => "These wool socks will gaurantee your feet are warm and dry.",
          :status => "False",
          :user_id => "1",
          :price => "35.00",
          :currency => "CAD",
          :product_category => "Unisex Clothing Accessories",
          :product_subcategory => "Socks" },
     
        { :name => "Sportful Tights", 
          :description => "These tights are sexy and fast. Perfect for the female athlete.",
          :status => "False",
          :user_id => "1",
          :price => "230.00",
          :currency => "CAD",
          :product_category => "Clothing Women",
          :product_subcategory => "Tights" },
        ]}

Product.create!(params[:products])


params = { :users => [
  
  {:email => 'merchant@sample.com',
  :password => 'password',
  :password_confirmation => 'password',
  
  }
]

}

User.create!(params[:users])





