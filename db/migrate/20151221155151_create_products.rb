class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.boolean :status
      t.integer :user_id
      t.decimal :price, :precision => 8, :scale => 2
      t.string :currency

      t.timestamps
    end
  end
end
