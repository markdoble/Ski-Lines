class DropJoinTable < ActiveRecord::Migration
  def change
    drop_table :orders_units
  end
end
