module UserFeedbackAnswersHelper
  def find_or_set_session_variable
    if session[:survey_session].blank?
      @survey_session = "no_survey_session"
    else
      if session[:survey_session_expiry] < Time.current
        @survey_session = "no_survey_session"
        session.delete(:survey_session_expiry)
        session.delete(:survey_session)
      else
        @survey_answer = UserFeedbackAnswer.find_by_id(session[:survey_session])
      end
    end
  end

  def build_form_for_newsfeed_partial
    @feedback_answer = UserFeedbackAnswer.new
  end

end
