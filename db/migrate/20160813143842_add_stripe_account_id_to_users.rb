class AddStripeAccountIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_account_id, :string
    add_column :users, :stripe_customer_id, :string
    change_column :users, :merchant_rep, :boolean, :default => false
    change_column :users, :article_publisher, :boolean, :default => false
    change_column :users, :merchant, :boolean, :default => false
  end
end
