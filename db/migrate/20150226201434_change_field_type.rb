class ChangeFieldType < ActiveRecord::Migration
  def change
    change_column :articles, :location, :text
    change_column :articles, :title, :text
    change_column :articles, :description, :text
    
    change_column :results, :location, :text
    
  end
end
