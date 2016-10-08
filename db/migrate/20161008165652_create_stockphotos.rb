class CreateStockphotos < ActiveRecord::Migration
  def change
    create_table :stockphotos do |t|
      t.string :sku
      t.string :name

      t.timestamps null: false
    end
  end
end
