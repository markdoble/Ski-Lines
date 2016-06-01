class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :summary
      t.string :province
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
