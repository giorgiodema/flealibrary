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
      console.log("Received data through channel")
      
      if data.type == "message"
        console.log("Type = MESSAGE")
        $("#"+data.chat_id).children(".input_box").val("")
        $("#"+data.chat_id).children(".message_box").append("<li class=received_message><p class=message_text> "+data.text+" </p></li>")

      if data.type == "delete_chat"
        console.log("Type = DELETE_CHAT")
        #console.log("deleting chat:"+"chat_item_"+data.chat_id)
        $("#chat_item_"+data.chat_id).remove()
        $("#"+data.chat_id).remove()

      if data.type == "create_chat"
        location.reload()

      if data.type == "new_notification"
        console.log("Type = NEW_NOTIFICATION")
        location.reload()