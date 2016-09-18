class Return < ActiveRecord::Base
  belongs_to :order_units
  belongs_to :order

  # scopes
  
end
