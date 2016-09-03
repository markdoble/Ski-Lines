class CreateDefaultPermittedDestinations < ActiveRecord::Migration
  def change
    create_table :default_permitted_destinations do |t|
      t.string :destination, array: true, default: []
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :default_permitted_destinations, :users
  end
end
