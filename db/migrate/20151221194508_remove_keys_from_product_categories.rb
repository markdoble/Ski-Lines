class RemoveKeysFromProductCategories < ActiveRecord::Migration
  def change
    remove_column :product_categories, :product_id
    remove_column :product_subcategories, :product_categories_id
    add_column :products, :product_category, :string
    add_column :products, :product_subcategory, :string
    add_column :products, :product_sub_subcategory, :string
  end
end
