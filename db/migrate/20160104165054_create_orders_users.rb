class CreateOrdersUsers < ActiveRecord::Migration
  def change
    create_table :orders_users, id: false do |t|
      t.belongs_to :order, index: true
      t.belongs_to :user, index: true
    end
  end
end
