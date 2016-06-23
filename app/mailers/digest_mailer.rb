class DigestMailer < ActionMailer::Base
  default from: "no-reply@ski-lines.com"

  def weekly_digest(subscriber, article_ids, subject)
    @url = 'https://www.ski-lines.com'
    @subscriber = EmailDigest.find_by_id(subscriber)
    @subject = subject
    articles_arr = []
    article_ids.each do |f|
      articles_arr << Article.find_by_id(f)
    end
    @articles = articles_arr

     mail(to: @subscriber.email,
          subject: subject)
  end

  def welcome_mail(subscriber_id)
    @url = 'https://www.ski-lines.com'
    @subscriber = EmailDigest.find_by_id(subscriber_id)
     mail(to: @subscriber.email,
          subject: "Welcome to the Ski-Lines Email Digest")
  end

end
