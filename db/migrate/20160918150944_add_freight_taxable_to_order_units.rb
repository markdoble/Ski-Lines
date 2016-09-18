class AddFreightTaxableToOrderUnits < ActiveRecord::Migration
  def change
    add_column :order_units, :freight_taxable, :boolean
  end
end
