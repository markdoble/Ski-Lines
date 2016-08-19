class ChangeUserNames < ActiveRecord::Migration
  def change
    add_column :users, :contact_last_name, :string
    rename_column :users, :contact_name, :contact_first_name
  end
end
