class Unit < ActiveRecord::Base
  belongs_to :product
  has_many :order_units, :class_name => 'OrderUnits'
  validates_numericality_of :quantity, :greater_than_or_equal_to => 0, :only_integer => true
  
  def prevent_deleting_units_with_sold_item
    unless self.quantity_sold.nil?
      self.errors[:base] << "You cannot delete a unit that has previously been sold. Mark inventory as 0 if you want to prevent future sales of this item."
      return false   
    end
  end
  
  
end