class AddShippingCurrenciesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :usd_domestic_shipping, :decimal, :precision => 8, :scale => 2
    add_column :products, :usd_foreign_shipping, :decimal, :precision => 8, :scale => 2
    rename_column :products, :domestic_shipping, :cad_domestic_shipping
    rename_column :products, :foreign_shipping, :cad_foreign_shipping
  end
end
