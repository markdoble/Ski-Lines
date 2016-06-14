module ArticlesHelper

  def youtube_embed(youtube_url)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end

    %Q{<iframe title="YouTube video player" width="100%" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
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

  def article_partial_selector
    

  end

end
