class AddDomesticShippingChargeToProductsAndUsers < ActiveRecord::Migration
  def change
    add_column :users, :domestic_shipping, :decimal, :precision => 8, :scale => 2
    add_column :users, :foreign_shipping, :decimal, :precision => 8, :scale => 2
    add_column :products, :domestic_shipping, :decimal, :precision => 8, :scale => 2
    add_column :products, :foreign_shipping, :decimal, :precision => 8, :scale => 2
  end
end
