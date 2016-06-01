class ChangeColumnType < ActiveRecord::Migration
  def up
    change_column :articles, :image, :text
    
  end
  
  def down
    change_column :articles, :image, :string
    
  end
  
end
