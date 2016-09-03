class ChangeColumnTypes < ActiveRecord::Migration
  def change
    change_column :permitted_destinations, :destination,  :string
    change_column :default_permitted_destinations, :destination,  :string
  end
end
