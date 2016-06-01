class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.integer :product_id
      t.string :size
      t.integer :quantity
      t.integer :quantity_sold

      t.timestamps
    end
  end
end
