class CreateOrderUnits < ActiveRecord::Migration
  def change
    create_table :order_units do |t|
      t.integer :order_id
      t.integer :unit_id
      t.integer :quantity

      t.timestamps
    end
  end
end
