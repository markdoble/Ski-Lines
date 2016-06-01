class CreateProductfotos < ActiveRecord::Migration
  def change
    create_table :productfotos do |t|
      t.belongs_to :product, index:true
      t.timestamps
    end
  end
end
