class MailboxController < ApplicationController
  layout "mailbox"
  before_action :authenticate_user!

  def inbox
    find_or_create_cart
    @inbox = mailbox.inbox
    @active = :inbox
  end

  def sent
    find_or_create_cart
    @sent = mailbox.sentbox
    @active = :sent
  end

  def trash
    find_or_create_cart
    @trash = mailbox.trash
    @active = :trash
  end

  private

  def find_or_create_cart
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end
  end
end
