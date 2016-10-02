class UserFeedbackAnswersController < ApplicationController
  layout "application"
  before_filter :find_categories

  def create
    @feedback_answer = UserFeedbackAnswer.create(feedback_answer_params)
    respond_to do |format|
      if @feedback_answer.save
        create_form_session_variables
        format.html { redirect_to root_path, notice: 'Thank you for your submission!' }
        format.js
      else
        format.html { redirect_to root_path, notice: 'There was an error processing your submission. Please try again.' }
        format.json { render json: @feedback_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def feedback_answer_params
      params.require(:user_feedback_answer).permit(:user_feedback_id, :answer_one, :answer_two, :answer_three, :answer_four, :answer_five, :answer_six)
    end

    def create_form_session_variables
      session[:survey_session] = @feedback_answer.id
      session[:survey_session_expiry] = Time.current + 120
    end

    def find_categories
      @root_categories = Category.where(parent_id: nil).order(:name)
    end

end
