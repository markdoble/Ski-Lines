class AddTaxAndShippingToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :sales_tax, :decimal, precision: 8, scale: 2
    add_column :orders, :shipping, :decimal, precision: 8, scale: 2
  end
end
