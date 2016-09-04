class Country < ActiveRecord::Base
  has_many :states
  accepts_nested_attributes_for :states

  has_many :permitted_destinations
  has_many :products, through: :permitted_destinations

    def country_name
      "#{common_name}"
    end
end
