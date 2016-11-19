class CreateStockfeatures < ActiveRecord::Migration
  def change
    create_table :stockfeatures do |t|
      t.string :name
      t.string :description
      t.references :stockproduct, index: true

      t.timestamps null: false
    end
    add_foreign_key :stockfeatures, :stockproducts
  end
end
