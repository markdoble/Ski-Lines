class UserFeedback < ActiveRecord::Base
  has_many :user_feedback_answers
  accepts_nested_attributes_for :user_feedback_answers, :allow_destroy => true, :reject_if => :all_blank
end
