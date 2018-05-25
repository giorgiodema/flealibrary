class ChatsController < ApplicationController


    def receive
    
        puts("params: #{params}")

        render template: "users/signin"

    end


end