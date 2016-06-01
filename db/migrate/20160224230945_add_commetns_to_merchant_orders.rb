class AddCommetnsToMerchantOrders < ActiveRecord::Migration
  def change
    add_column :merchant_orders, :customer_comments, :text
  end
end
