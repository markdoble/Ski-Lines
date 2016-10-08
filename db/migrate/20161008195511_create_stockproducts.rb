class CreateStockproducts < ActiveRecord::Migration
  def change
    create_table :stockproducts do |t|
      t.string :name
      t.text :description
      t.decimal :msrp, :precision => 8, :scale => 2
      t.text :size_details
      t.string :sku
      t.string :brand
      t.references :stockphoto, index: true

      t.timestamps null: false
    end
    add_foreign_key :stockproducts, :stockphotos
  end
end
