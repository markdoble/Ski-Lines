class AddAttributesToOrderAndUser < ActiveRecord::Migration
  def change
    add_column :orders, :street_address, :string
    add_column :orders, :prov_state, :string
    add_column :orders, :country, :string
    add_column :orders, :postal_zip, :string
    add_column :orders, :cust_first_name, :string
    add_column :orders, :cust_last_name, :string
    add_column :orders, :cust_email, :string
    add_column :orders, :cust_phone, :string
    add_column :orders, :status, :string
    add_column :orders, :marketing_optout, :boolean
    
    add_column :users, :shipping_cost, :decimal, :precision => 8, :scale => 2
    add_column :users, :sales_tax, :decimal, :precision => 2, :scale => 2
  end
end
