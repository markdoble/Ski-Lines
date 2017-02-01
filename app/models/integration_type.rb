class IntegrationType < ActiveRecord::Base
  # Define the varidations needed for the category model
  validates :name, presence: true, length: { minimum: 4 }
  validates :desc, presence: true, length: { minimum: 4 }
  validates :status, inclusion: [true, false]
  validates :auth_method, presence: true, length: { minimum: 4 }
  validates :always_authenticate, inclusion: [true, false]

  # Associations needed to implement the foreign key relationships
  belongs_to :parent, class_name: 'Integration', foreign_key: 'integration_type_id'

  # Scope that will return integration types that are available to a user. A type is only available when the user has no existing integration with it.
  scope :types_available_to_user, ->(user_id) { where("id NOT IN(SELECT integration_type_id FROM integrations WHERE user_id = ?)", user_id) }
end
