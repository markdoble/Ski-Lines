class CreateStockunits < ActiveRecord::Migration
  def change
    create_table :stockunits do |t|
      t.belongs_to :stockproduct, index: true
      t.string :size
      t.string :quantity
      t.string :colour
      t.timestamps null: false
    end
  end
end
