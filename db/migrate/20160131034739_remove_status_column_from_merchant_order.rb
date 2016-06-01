class RemoveStatusColumnFromMerchantOrder < ActiveRecord::Migration
  def change
    remove_column :merchant_orders, :status, :boolean
  end
end
