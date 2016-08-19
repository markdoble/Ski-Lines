class AddSalesTaxAndShippingToOrderUnits < ActiveRecord::Migration
  def change
    add_column :order_units, :sales_tax_charged, :decimal, precision: 8, scale: 2
    add_column :order_units, :shipping_charged, :decimal, precision: 8, scale: 2
    add_column :users, :merchant_rep, :boolean
  end
end
