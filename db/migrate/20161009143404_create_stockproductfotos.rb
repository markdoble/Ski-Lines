class CreateStockproductfotos < ActiveRecord::Migration
  def change
    create_table :stockproductfotos do |t|
      t.references :stockproduct, index: true

      t.timestamps null: false
    end
    add_foreign_key :stockproductfotos, :stockproducts
  end
end
