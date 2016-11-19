class CreateProductFeatures < ActiveRecord::Migration
  def change
    create_table :product_features do |t|
      t.references :product, index: true
      t.references :feature, index: true

      t.timestamps null: false
    end
    add_foreign_key :product_features, :products
    add_foreign_key :product_features, :features
  end
end
