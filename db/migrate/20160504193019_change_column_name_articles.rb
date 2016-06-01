class ChangeColumnNameArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :format, :article_format
  end
end
