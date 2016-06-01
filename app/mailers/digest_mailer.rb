class DigestMailer < ActionMailer::Base
  default from: "digest@ski-lines.com"

  def weekly_digest(subscriber, article_ids, subject)
    @url = 'http://www.ski-lines.com'
    @subscriber = EmailDigest.find_by_id(subscriber)
    @subject = subject
    articles_arr = []
    article_ids.each do |f|
      articles_arr << Article.find_by_id(f)
    end
    @articles = articles_arr

    delivery_options = { user_name: 'digest@ski-lines.com',
                         password: ENV['EMAIL_PASS'],
                         address: "smtp.zoho.com"}

     mail(to: @subscriber.email,
          subject: subject,
          delivery_method_options: delivery_options)
  end

  def welcome_mail(subscriber_id)
    @url = 'http://www.ski-lines.com'

    @subscriber = EmailDigest.find_by_id(subscriber_id)

    delivery_options = { user_name: 'digest@ski-lines.com',
                         password: ENV['EMAIL_PASS'],
                         address: "smtp.zoho.com"}

     mail(to: @subscriber.email,
          subject: "Welcome to the Ski-Lines Email Digest",
          delivery_method_options: delivery_options)
  end

end
