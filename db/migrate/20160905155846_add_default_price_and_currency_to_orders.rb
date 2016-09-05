class AddDefaultPriceAndCurrencyToOrders < ActiveRecord::Migration
  def change
    change_column_default :products, :usd_price, 0
    change_column_default :products, :cad_price, 0
    change_column_default :products, :price, 0
    add_column :orders, :currency, :string
    add_column :order_units, :currency, :string
  end
end
