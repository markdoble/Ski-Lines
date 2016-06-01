class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.string :category
      t.integer :product_id

      t.timestamps
    end
  end
end
