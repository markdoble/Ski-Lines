class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :date
      t.string :city
      t.string :country
      t.string :format
      t.string :location
      t.string :category

      t.timestamps
    end
  end
end
