module Admin::ArticleHelper

  def admin_article_partial_selector(article)
      case article.article_format
      when "youtube_video"
        render partial: "articles/newsfeed_format/video_art", locals: {:article => article}
      when "facebook_video"
        render partial: "articles/newsfeed_format/facebook_video", locals: {:article => article}
      when "sponsor"
        render partial: "articles/newsfeed_format/advert", locals: {:article => article}
      when "email_digest_form"
        nil
      when "user_poll"
        render partial: 'admin/articles/admin_newsfeed_partials/user_poll', locals: {:article => article}
      else
        render partial: "articles/newsfeed_format/standard", locals: {:article => article}
      end

  end


end
