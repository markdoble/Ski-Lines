class DeleteExistingCategories < ActiveRecord::Migration
  def change
    drop_table :product_subcategories
    drop_table :product_categories
    remove_column :products, :product_category
    remove_column :products, :product_subcategory
    remove_column :products, :product_sub_subcategory
  end
end
