class AddTransactionIdToOrder < ActiveRecord::Migration
  def change
   add_column :orders, :transaction_id, :string
  end
end
