module UserFeedbacksHelper

  def build_nested_feedbacks_object(article)
    @feedback = article.user_feedback.user_feedback_answers.build

  end

end
