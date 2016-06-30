class AddSuccessToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :success, :boolean
  end
end
