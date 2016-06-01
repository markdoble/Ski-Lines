class ChangeStatusDatatypeToBoolean < ActiveRecord::Migration
  def change
      add_column :merchant_orders, :order_status, :boolean
  end
end
