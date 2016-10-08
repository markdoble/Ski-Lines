class AddStockphotoToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :stockphoto, index: true
    add_foreign_key :products, :stockphotos
  end
end
