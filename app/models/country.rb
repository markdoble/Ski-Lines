class Country < ActiveRecord::Base
  has_many :states
  accepts_nested_attributes_for :states

    def country_name
      "#{common_name}"
    end
end
