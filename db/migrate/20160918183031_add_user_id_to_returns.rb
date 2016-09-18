class AddUserIdToReturns < ActiveRecord::Migration
  def change
    add_reference :returns, :user, index: true
    add_foreign_key :returns, :users
  end
end
