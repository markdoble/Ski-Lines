class CreateUserFeedbackAnswers < ActiveRecord::Migration
  def change
    create_table :user_feedback_answers do |t|
      t.string :answer_one
      t.string :answer_two
      t.string :answer_three
      t.string :answer_four
      t.string :answer_five
      t.string :answer_six
      t.references :user_feedback, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_feedback_answers, :user_feedbacks
  end
end
