class AddProductContentRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :stockproduct_permission, :boolean
  end
end
