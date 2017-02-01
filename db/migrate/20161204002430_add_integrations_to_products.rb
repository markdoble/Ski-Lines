class AddIntegrationsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :integration_id, :integer
    add_column :products, :integration_external_id, :string, limit: 150
  end
end
