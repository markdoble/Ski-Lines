class AddImageSizeToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :img_size, :string
  end
end
