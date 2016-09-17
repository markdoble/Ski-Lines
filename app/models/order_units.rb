class OrderUnits < ActiveRecord::Base
  belongs_to :unit
  belongs_to :order
  has_one :return
end
