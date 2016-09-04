class ChangePermittedColumnName < ActiveRecord::Migration
  def change
    add_column :permitted_destinations, :country_id, :integer
    add_column :default_permitted_destinations, :country_id, :integer
    add_foreign_key :permitted_destinations, :countries
    add_foreign_key :default_permitted_destinations, :countries
    remove_column :permitted_destinations, :destination
    remove_column :default_permitted_destinations, :destination
  end
end
