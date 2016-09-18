class AddAttributesToReturns < ActiveRecord::Migration
  def change
    add_column :returns, :suggested_sub_total, :decimal, precision: 8, scale: 2
    add_column :returns, :suggested_sales_tax, :decimal, precision: 8, scale: 2
    add_column :returns, :suggested_shipping_charge, :decimal, precision: 8, scale: 2

    add_column :returns, :actual_sub_total_refunded, :decimal, precision: 8, scale: 2
    add_column :returns, :actual_sales_tax_refunded, :decimal, precision: 8, scale: 2
    add_column :returns, :actual_shipping_charge_refunded, :decimal, precision: 8, scale: 2

    add_column :returns, :default_sub_total, :decimal, precision: 8, scale: 2
    add_column :returns, :default_sales_tax, :decimal, precision: 8, scale: 2
    add_column :returns, :default_shipping_charge, :decimal, precision: 8, scale: 2

    add_column :returns, :refund_complete, :boolean
  end
end
