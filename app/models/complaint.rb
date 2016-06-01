class Complaint < ActiveRecord::Base
  validates_format_of :customer_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :cust_first_name, :presence => {:message => 'Please fill out your name.'}
  validates :cust_last_name, :presence => {:message => 'Please fill out your name.'}
  validates :complaint_description, :presence => {:message => 'Please fill out your complaint.'}
  validates :order_id_number, :presence => {:message => 'Please tell us your Order ID #.'}
end
