class UsersController < ApplicationController

    # FAKE SIGNIN
    def sign_in
        if request.get?
            render "signin"


        else
            curr_user = params[:username]
            puts("USERNAME = #{curr_user}")#debug

            if User.where(username:curr_user).none?
                User.create(username:curr_user)
            end

            uid = User.where(username:curr_user).first.id
            session[:current_user] = uid

            redirect_to action: 'profile'

        end

    end

    # FAKE PROFILE used to render chat partial
    def profile
        @user = self.current_user
    end

end
