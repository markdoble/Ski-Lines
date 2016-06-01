class CreateOrdersUnits < ActiveRecord::Migration
  def change
    create_table :orders_units, id: false do |t|
      t.belongs_to :order, index: true
      t.belongs_to :unit, index: true
    end
  end
end
