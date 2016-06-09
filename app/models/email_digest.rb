class EmailDigest < ActiveRecord::Base

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :first_name, :presence => {:message => 'Please fill out your first name.'}
  validates :last_name, :presence => {:message => 'Please fill out your last name.'}

  def self.send_email_digest(article_ids, subject)
    subscribers = EmailDigest.where(status: "Active")

    subscribers.each do |subscriber|
       DigestMailer.weekly_digest(subscriber.id, article_ids, subject).deliver_later
    end
  end

end
