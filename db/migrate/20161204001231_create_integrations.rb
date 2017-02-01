class CreateIntegrations < ActiveRecord::Migration
  def change
    create_table :integrations do |t|
      t.references :user, index: true
      t.references :integration_type, index: true
      t.string :account_external_id, limit: 150
      t.string :api_key, limit: 300
      t.string :access_token, limit: 300
      t.string :refresh_token, limit: 300
      t.boolean :allow_auto_scrape

      t.timestamps null: false
    end
    add_foreign_key :integrations, :users
    add_foreign_key :integrations, :integration_types
  end
end
