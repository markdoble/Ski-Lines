class AddAttachmentFotoToProductfotos < ActiveRecord::Migration
  def self.up
    change_table :productfotos do |t|
      t.attachment :foto
    end
  end

  def self.down
    remove_attachment :productfotos, :foto
  end
end
