class AddAttachmentFotoToStockproductfotos < ActiveRecord::Migration
  def self.up
    change_table :stockproductfotos do |t|
      t.attachment :foto
    end
  end

  def self.down
    remove_attachment :stockproductfotos, :foto
  end
end
