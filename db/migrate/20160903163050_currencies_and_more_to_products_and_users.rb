class CurrenciesAndMoreToProductsAndUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_for_orders, :string
    add_column :products, :usd_price, :decimal, :precision => 8, :scale => 2
    add_column :products, :cad_price, :decimal, :precision => 8, :scale => 2
    add_column :products, :factory_sku, :string
  end
end
