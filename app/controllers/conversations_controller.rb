class ConversationsController < ApplicationController
  layout "store_layout"
  before_action :authenticate_user!

  def new
    find_or_create_cart
    # get the current product based on the querystring value
    cur_product = Product.where(id: params[:product_id]).first
    # set the variables needed on the compose new message view. We want to preset the recipient and subject
    @preset_subject = cur_product.name + " Inquiry"
    @preset_merchant_id = cur_product.user.id
    @preset_merchant_name = cur_product.user.merchant_name
  end

  def create
    find_or_create_cart
    recipient_id = User.where(id: conversation_params[:recipient_id])
    conversation = current_user.send_message(recipient_id, conversation_params[:body], conversation_params[:subject]).conversation
    flash.now[:success] = "Your message was successfully sent!"
    #redirect_to conversation_path(conversation)
    redirect_to '/cart'
  end

  def show
    find_or_create_cart
    @receipts = conversation.receipts_for(current_user).order(created_at: :asc)
    conversation.mark_as_read(current_user)
  end

  def reply
    find_or_create_cart
    current_user.reply_to_conversation(conversation, message_params[:body])
    flash.now[:notice] = "Your reply message was successfully sent!"
    redirect_to conversation_path(conversation)
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to mailbox_inbox_path
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to mailbox_sent_path
  end

  def delete
    conversation.mark_as_deleted(current_user)
    redirect_to mailbox_trash_path
  end

  def empty_trash
    mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash.now[:success] = 'Your trash was cleaned!'
    redirect_to mailbox_trash_path
  end

  def find_or_create_cart
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:subject, :body, :recipient_id)
  end

  def message_params
    params.require(:message).permit(:body, :subject)
  end

end
