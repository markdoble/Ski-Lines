# Seed data for initial category layout
params = {
  :categories => [
      { :name => "Skis",
        :description => "Skis Description"
      },

      { :name => "Boots",
        :description => "Boots Description"
      },

      { :name => "Poles",
        :description => "Poles Description"
      },

      { :name => "Clothing",
        :description => "Clothing Description"
      },

      { :name => "Waxing",
        :description => "Waxing Description"
      },

      { :name => "Accessories",
        :description => "Accessories Description"
      }
    ]
  }

Category.create!(params[:categories])
