class ChatsController < ApplicationController


    def receive

        @answer = {}
        @chat = Chat.find(params["msg"]["chat_id"])

        new_message = Message.create()
        new_message.chat = @chat
        new_message.text = params["msg"]["text"]

        new_message.set_from self.current_user.username

        
        new_message.save
        @chat.messages.append(new_message)


        @answer = {status:"saved"}
        render json: @answer

    end


end