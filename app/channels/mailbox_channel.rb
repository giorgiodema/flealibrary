class MailboxChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "mailbox_#{params[:userid]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
