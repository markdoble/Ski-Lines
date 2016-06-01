class MerchantApplication < ActiveRecord::Base
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :merchant_name, :presence => {:message => 'Please fill out your store name.'}
  validates :email, :presence => {:message => 'Please fill out your email address.'}
  validates :country, :presence => {:message => 'Please select your Country.'}
  validates :state_prov, :presence => {:message => 'Please select your State/Province.'}
  validates :zip_postal, :presence => {:message => 'Please fill out your ZIP/Postal Code.'}
  validates :city, :presence => {:message => 'Please fill out your City.'}
  validates :street_address, :presence => {:message => 'Please fill out your Street Address.'}
  validates :contact_name, :presence => {:message => 'Please enter a contact name for your store.'}
  validates :merchant_phone, :presence => {:message => 'Please fill out your phone number.'}
  
 
end
