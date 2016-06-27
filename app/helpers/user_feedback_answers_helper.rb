module UserFeedbackAnswersHelper
  def find_or_set_session_variable(article)
    if session[:survey_session].blank?
      @survey_session = "no_survey_session" << article.id
    else
      if session[:survey_session_expiry] < Time.current
        @survey_session = "no_survey_session" << article.id
        session.delete(:survey_session_expiry)
        session.delete(:survey_session)
      else
        survery_answer = UserFeedbackAnswer.find_by_id(session[:survey_session] )

        if survery_answer.user_feedback.article_id == article.id
          @survey_answer = UserFeedbackAnswer.find_by_id(session[:survey_session] )
        else
          @survey_session = "no_survey_session" << article.id
        end
      end
    end
  end

  def build_form_for_newsfeed_partial
    @feedback_answer = UserFeedbackAnswer.new
  end


end
