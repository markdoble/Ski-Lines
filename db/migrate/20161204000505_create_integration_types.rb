class CreateIntegrationTypes < ActiveRecord::Migration
  def change
    create_table :integration_types do |t|
      t.string :name, limit: 150
      t.string :desc, limit: 300
      t.boolean :status
      t.string :auth_method, limit: 150
      t.boolean :always_authenticate

      t.timestamps null: false
    end
  end
end
