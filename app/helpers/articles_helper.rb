module ArticlesHelper

  def youtube_embed(location)
    youtube_id = location.split("=").last
    
    %Q{<iframe title="YouTube video player" width="640" height="390" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
  end

  def newsfeed_partial_selector(article)
    if article.image.include? "youtube.com"
		    render partial: "articles/newsfeed_format/video_art", locals: {:article => article}
	  elsif article.image.include? "facebook.com" and "video"
		    render partial: "articles/newsfeed_format/facebook_video", locals: {:article => article}
		elsif article.notes == "Sponsor"
		    render partial: "articles/newsfeed_format/advert", locals: {:article => article}
    elsif article.article_format == "email_digest_form"
        render partial: "email_digests/form", locals: {:article => article}
    else
		    render partial: "articles/newsfeed_format/standard", locals: {:article => article}
	  end
  end

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
      when "sponsor"
        nil
      when "email_digest_form"
        nil
      else
        render partial: "articles/show_format/stand_show", locals: {:article => article}
      end
  end

end
