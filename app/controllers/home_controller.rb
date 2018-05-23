class HomeController < ApplicationController
    skip_before_action :authenticate_user!, :only => [:welcome]

    def welcome
    end
    
    def profile
        @user = current_user
    end
end
