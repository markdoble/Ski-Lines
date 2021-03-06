module ArticlesHelper

  def youtube_embed(location)
    location.split("=").last
  end

  # Used to select newsfeed articles
  def article_partial_selector(article)
      case article.article_format
      when "youtube_video"
        render partial: "articles/newsfeed_format/video_art", locals: {:article => article}
      when "facebook_video"
        render partial: "articles/newsfeed_format/facebook_video", locals: {:article => article}
      when "sponsor"
        render partial: "articles/newsfeed_format/advert", locals: {:article => article}
      when "email_digest_form"
        render partial: "email_digests/form", locals: {:article => article}
      when "user_poll"
        render partial: 'user_feedback_answers/newsfeed_user_poll', locals: {:article => article}
      else
        render partial: "articles/newsfeed_format/standard", locals: {:article => article}
      end

  end
  def article_show_partial_selector(article)
      case article.article_format
      when "youtube_video"
        render partial: "articles/show_format/video_show", locals: {:article => article}
      when "facebook_video"
        render partial: "articles/show_format/facebook_video_show", locals: {:article => article}
      when "user_poll"
        render partial: 'user_feedback_answers/newsfeed_user_poll', locals: {:article => article}
      when "sponsor"
        nil
      when "email_digest_form"
        nil
      else
        render partial: "articles/show_format/stand_show", locals: {:article => article}
      end
  end
  def feature_videos_partial_selector(article)
    case article.article_format
    when "youtube_video"
      render :partial => "articles/right_side_bar/side_yt_vid", :locals => {:article => article}
    when "facebook_video"
      render :partial => "articles/right_side_bar/side_fb_vid", :locals => {:article => article}
    else
      nil
    end
  end

end
