$(document).ready ->
  user = $("[name='userid']").attr("content")

  App.mailbox = App.cable.subscriptions.create {channel:"MailboxChannel",userid:user},
    connected: ->
      # Called when the subscription is ready for use on the server
      console.log("Channel Open")
    disconnected: ->
      # Called when the subscription has been terminated by the server
      console.log("Channel Closed")
    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
      console.log("you received data through channel")
      $("#"+data.chat_id).children(".input_box").val("")
      $("#"+data.chat_id).children(".message_box").append("<li class=received_message><p class=message_text> "+data.text+" </p></li>")