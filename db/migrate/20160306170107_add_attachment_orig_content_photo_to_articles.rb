class AddAttachmentOrigContentPhotoToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.attachment :orig_content_photo
    end
  end

  def self.down
    remove_attachment :articles, :orig_content_photo
  end
end
