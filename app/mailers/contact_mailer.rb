class ContactMailer < ActionMailer::Base
  default from: "no-reply@ski-lines.com"

  def contact_form_submit(contact)
    @contact = contact
    @url = 'http://www.ski-lines.com'
    mail(to: 'mark@ski-lines.com', subject: 'New Contact Form Submission')
  end

end
