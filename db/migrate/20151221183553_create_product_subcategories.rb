class CreateProductSubcategories < ActiveRecord::Migration
  def change
    create_table :product_subcategories do |t|
      t.string :subcategory
      t.integer :product_categories_id

      t.timestamps
    end
  end
end
