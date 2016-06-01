class AddAttributesToMerchantOrders < ActiveRecord::Migration
  def change
    add_column :merchant_orders, :delivery_method, :string
    add_column :merchant_orders, :product_id, :integer
  end
end
