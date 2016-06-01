class CreateMerchantApplications < ActiveRecord::Migration
  def change
    create_table :merchant_applications do |t|
      t.string :merchant_name
      t.string :email
      t.string :country
      t.string :state_prov
      t.string :zip_postal
      t.string :city
      t.string :street_address
      t.string :contact_name
      t.string :merchant_phone
      t.boolean :current_selling_online
      t.string :website_url

      t.timestamps
    end
  end
end
