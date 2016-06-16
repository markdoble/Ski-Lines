Article.each do |f|
  if f.image.include? "youtube.com"
    f.update_attribute(:article_format, "youtube_video")
  elsif f.image.include? "facebook.com" and "video"
    f.update_attribute(:article_format, "facebook_video")
  elsif f.notes == "Sponsor"
    f.update_attribute(:article_format, "sponsor")
  elsif f.article_format == "email_digest_form"
    next
  else
    f.update_attribute(:article_format, "standard")
  end
end
