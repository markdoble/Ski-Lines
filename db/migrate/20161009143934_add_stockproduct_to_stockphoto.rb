class AddStockproductToStockphoto < ActiveRecord::Migration
  def change
    add_reference :stockphotos, :stockproduct, index: true
    add_foreign_key :stockphotos, :stockproducts
    remove_column :stockproducts, :stockphoto_id
  end
end
