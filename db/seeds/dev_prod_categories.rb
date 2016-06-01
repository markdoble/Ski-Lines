

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
