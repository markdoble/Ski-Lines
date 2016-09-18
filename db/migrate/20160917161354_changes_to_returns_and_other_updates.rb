class ChangesToReturnsAndOtherUpdates < ActiveRecord::Migration
  def change
    add_column :order_units, :application_fee_applied, :decimal, precision: 8, scale: 2
    add_column :order_units, :sales_tax_rate, :decimal, precision: 8, scale: 4

    remove_column :returns, :amount_returned
    remove_column :returns, :unit_returned
    remove_column :returns, :exchanged
    remove_column :returns, :amount_to_charge
  end
end
