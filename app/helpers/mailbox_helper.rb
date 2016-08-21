module MailboxHelper

  # retrieves the number of unread messages for the current user
  def unread_messages_count
    mailbox.inbox(:unread => true).count(:id, :distinct => true)
  end

end
