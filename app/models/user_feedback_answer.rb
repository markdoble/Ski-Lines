class UserFeedbackAnswer < ActiveRecord::Base
  belongs_to :user_feedback

  validates_length_of :answer_one, :minimum => 1, :maximum => 255, :allow_blank => true
  validates_length_of :answer_two, :minimum => 1, :maximum => 255, :allow_blank => true
  validates_length_of :answer_three, :minimum => 1, :maximum => 255, :allow_blank => true
  validates_length_of :answer_four, :minimum => 1, :maximum => 255, :allow_blank => true
  validates_length_of :answer_five, :minimum => 1, :maximum => 255, :allow_blank => true
  validates_length_of :answer_six, :minimum => 1, :maximum => 255, :allow_blank => true
end
