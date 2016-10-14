class CreateStockproductAndCategoryJoins < ActiveRecord::Migration
  def change
    create_table :stockproduct_categories do |t|
      t.belongs_to :stockproduct, index: true
      t.belongs_to :category, index: true
      t.timestamps
    end
  end
end
