class ProductToPhotoJoinsTable < ActiveRecord::Migration
  def change
    create_table :product_stockphotos do |t|
      t.belongs_to :product, index: true
      t.belongs_to :stockphoto, index: true
      t.timestamps
    end

    create_table :product_stockproductfotos do |t|
      t.belongs_to :product, index: true
      t.belongs_to :stockproductfoto, index: true
      t.timestamps
    end
  end
end
