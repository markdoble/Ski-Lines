class AddStatusToStockproducts < ActiveRecord::Migration
  def change
    add_column :stockproducts, :ca_status, :boolean
    add_column :stockproducts, :us_status, :boolean
    add_column :stockproducts, :usd_msrp, :decimal, :precision => 8, :scale => 2
    rename_column :stockproducts, :msrp, :cad_msrp
  end
end
