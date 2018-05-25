class ChatsController < ApplicationController


    def receive

        @answer = {}
        @chat = Chat.find(params["msg"]["chat_id"])

        new_message = Message.create()
        new_message.chat = @chat
        new_message.text = params["msg"]["text"]

        new_message.set_from self.current_user.username

        
        new_message.save
        puts("\n\n--------------------------------\n\n")
        puts("Message from: #{new_message.from?.username}")
        puts("          to: #{new_message.to?.username}")
        puts("        text: #{new_message.text}")
        @chat.messages.append(new_message)

        receiver_id = 1 #new_message.to?.id
        msg = {
            chat_id:new_message.chat_id,
            text:new_message.text
        }
        
        # Somewhere in your app this is called, perhaps
        # from a NewCommentJob.
        ActionCable.server.broadcast(
            "mailbox_#{receiver_id}",
            sent_by: 'Paul',
            body: 'This is a cool chat app.'
        )


        @answer = {status:"saved"}
        render json: @answer

    end


end