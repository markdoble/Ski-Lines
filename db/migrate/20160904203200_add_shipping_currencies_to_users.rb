class AddShippingCurrenciesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :usd_domestic_shipping, :decimal, :precision => 8, :scale => 2
    add_column :users, :usd_foreign_shipping, :decimal, :precision => 8, :scale => 2
    rename_column :users, :domestic_shipping, :cad_domestic_shipping
    rename_column :users, :foreign_shipping, :cad_foreign_shipping
  end
end
