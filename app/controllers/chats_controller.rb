class ChatsController < ApplicationController


    def receive
        puts("ChatController#receive:::received a message")
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

        receiver_id = new_message.to?.id
        msg = {
            type:"message",
            chat_id:new_message.chat_id,
            text:new_message.text
        }
        

        ActionCable.server.broadcast(
            "mailbox_#{receiver_id}",
            msg
        )


        @answer = {status:"saved"}
        render json: @answer

    end


    def delete_chat
        @answer = {}
        @chat = Chat.find(params["chat_id"])

        owner_id = @chat.owner.id
        guest_id = @chat.guest.id

        msg = {
            type:"delete_chat",
            chat_id: @chat.id
        }

        ActionCable.server.broadcast(
            "mailbox_#{owner_id}",
            msg
        )

        ActionCable.server.broadcast(
            "mailbox_#{guest_id}",
            msg
        )
        
        @chat.destroy

        @answer = {status:"deleted"}
        render json: @answer
    end


end