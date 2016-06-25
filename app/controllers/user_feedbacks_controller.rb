class UserFeedbacksController < ApplicationController
  layout "admin_application"

  def new
    @feedback = UserFeedback.new
  end

  def create
    @feedback = UserFeedback.create(user_feedback_params)
    respond_to do |format|
      if @feedback.save
        format.html { redirect_to root_path, notice: 'Thank you for your submission!' }
        format.js
      else
        format.html { redirect_to root_path, notice: 'There was an error processing your submission. Please try again.' }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @feedback = UserFeedback.find(params[:id])
  end

  def update
    @feedback = UserFeedback.find(params[:id])
    respond_to do |format|
    if @feedback.update(user_feedback_params)
      format.html {redirect_to root_path, notice: 'Successfully updated questionnaire.'}
      format.json {render json: @feedback }
      else
     redirect_to admin_articles_path
     end
   end
  end


  private
    def user_feedback_params
      params.require(:user_feedback).permit(:question_one, :question_two, :question_three, :question_four, :question_five, :question_six, :user_feedback_answers_attributes => [:user_feedback_id, :answer_one, :answer_two, :answer_three, :answer_four, :answer_five, :answer_six])
    end
end
