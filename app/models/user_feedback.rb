class UserFeedback < ActiveRecord::Base
  has_many :user_feedback_answers
  accepts_nested_attributes_for :user_feedback_answers, :allow_destroy => true, :reject_if => lambda { |a| a[:user_feedback_id].blank? }
end
