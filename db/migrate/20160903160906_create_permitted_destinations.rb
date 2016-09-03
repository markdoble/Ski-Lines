class CreatePermittedDestinations < ActiveRecord::Migration
  def change
    create_table :permitted_destinations do |t|
      t.string :destination, array: true, default: []
      t.references :product, index: true

      t.timestamps null: false
    end
    add_foreign_key :permitted_destinations, :products
  end
end
