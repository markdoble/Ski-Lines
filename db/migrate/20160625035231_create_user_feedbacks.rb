class CreateUserFeedbacks < ActiveRecord::Migration
  def change
    create_table :user_feedbacks do |t|
      t.string :question_one
      t.string :question_two
      t.string :question_three
      t.string :question_four
      t.string :question_five
      t.string :question_six

      t.timestamps null: false
    end
  end
end
