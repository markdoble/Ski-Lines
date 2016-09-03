class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :alpha_2_code
      t.string :common_name

      t.timestamps null: false
    end
  end
end
