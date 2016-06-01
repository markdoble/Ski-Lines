class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.string :cust_first_name
      t.string :cust_last_name
      t.string :customer_email
      t.text :complaint_description
      t.string :accused_seller
      t.string :order_id_number

      t.timestamps
    end
  end
end
