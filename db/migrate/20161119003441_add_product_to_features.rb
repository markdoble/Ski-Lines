class AddProductToFeatures < ActiveRecord::Migration
  def change
    add_reference :features, :product, index: true
    add_foreign_key :features, :products
  end
end
