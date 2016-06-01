class AddAmountAndCityToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :amount, :decimal, precision: 8, scale: 2
    add_column :users, :city, :string
    add_column :orders, :city, :string
  end
end
