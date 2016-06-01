class AddNotesToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :notes, :string
  end
end
