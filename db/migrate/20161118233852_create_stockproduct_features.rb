class CreateStockproductFeatures < ActiveRecord::Migration
  def change
    create_table :stockproduct_features do |t|
      t.references :stockproduct, index: true
      t.references :feature, index: true

      t.timestamps null: false
    end
    add_foreign_key :stockproduct_features, :stockproducts
    add_foreign_key :stockproduct_features, :features
  end
end
