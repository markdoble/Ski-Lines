class AddAdvertisementToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :advertisement, :string
  end
end
