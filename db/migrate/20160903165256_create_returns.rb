class CreateReturns < ActiveRecord::Migration
  def change
    create_table :returns do |t|
      t.references :order_units, index: true
      t.integer :qty_returned
      t.decimal :amount_returned
      t.text :reason
      t.integer :unit_returned
      t.references :order, index: true
      t.boolean :exchanged
      t.decimal :amount_to_charge

      t.timestamps null: false
    end
    add_foreign_key :returns, :order_units, column: :order_units_id
    add_foreign_key :returns, :orders
  end
end
