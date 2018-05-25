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