class DropHabtmTable < ActiveRecord::Migration
  def up
    drop_table :orders_users
  end
end
