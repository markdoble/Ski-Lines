class AddPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :shipping_charge, :decimal, precision: 8, scale: 2
  end
end
