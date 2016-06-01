class AddFieldsToUserAndProduct < ActiveRecord::Migration
  def change
    add_column :users, :user_return_policy, :text
    add_column :products, :product_return_policy, :text
    add_column :units, :colour, :string
  end
end
