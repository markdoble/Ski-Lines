class DropTables < ActiveRecord::Migration
  def change
    drop_table :stockproduct_features
    drop_table :product_features
  end
end
