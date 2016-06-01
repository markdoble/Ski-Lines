class AddForeignKeysToCategories < ActiveRecord::Migration
  def change
    add_column :product_subcategories, :product_category_id, :integer
    
  end
end
