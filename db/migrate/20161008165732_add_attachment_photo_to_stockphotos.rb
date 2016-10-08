class AddAttachmentPhotoToStockphotos < ActiveRecord::Migration
  def self.up
    change_table :stockphotos do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :stockphotos, :photo
  end
end
