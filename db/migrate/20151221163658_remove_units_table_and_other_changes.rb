class RemoveUnitsTableAndOtherChanges < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :merchant_name, :string
    add_column :users, :contact_name, :string
    add_column :users, :country, :string
    add_column :users, :state_prov, :string
    add_column :users, :zip_postal, :string
    add_column :users, :merchant_url, :string
    add_column :users, :merchant_phone, :string
    add_column :users, :street_address, :string
    
    
  end
end

