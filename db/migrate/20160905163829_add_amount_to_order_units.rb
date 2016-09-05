class AddAmountToOrderUnits < ActiveRecord::Migration
  def change
    add_column :order_units, :sub_total, :decimal, precision: 8, scale: 2
  end
end
