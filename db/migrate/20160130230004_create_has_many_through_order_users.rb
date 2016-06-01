class CreateHasManyThroughOrderUsers < ActiveRecord::Migration
  def change
    create_table :merchant_orders do |t|
      t.integer :order_id
      t.integer :user_id
      t.string :status
      t.timestamps
    end
  end
end
