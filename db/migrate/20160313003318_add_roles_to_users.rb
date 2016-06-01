class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :merchant, :boolean
    add_column :users, :article_publisher, :boolean
  end
end
