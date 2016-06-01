class AddSizingToProducts < ActiveRecord::Migration
  def change
    add_column :products, :size_details, :text
  end
end
