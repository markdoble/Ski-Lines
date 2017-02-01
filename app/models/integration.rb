class Integration < ActiveRecord::Base

  # Define the varidations needed for the category model
  validates :user_id, presence: true
  validates :integration_type_id, presence: true
  validates :allow_auto_scrape, inclusion: [true, false]

  # Associations needed to implement the foreign key relationships
  belongs_to :user
  belongs_to :integration_type
end
