class ChangeUnitSizeColumnType < ActiveRecord::Migration
  def change
    change_column :units, :size,  :text
  end
end
