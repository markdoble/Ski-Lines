class ChangeAdvertisementAttributeonArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :advertisement, :format
  end
end
