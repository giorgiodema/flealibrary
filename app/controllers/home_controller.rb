class HomeController < ApplicationController
    skip_before_action :authenticate_user!, :only => [:welcome, :ads_list]

    def welcome
    end
    
    def profile
        @user = current_user
        @chats = @user.chats
        #@c = @user.chats.first
    end

    def ads_list
        @ad = params[:search][0].downcase
        @ads = Ad.where( "book_title like?", "%#{@ad}%")
        if @ads.size.zero?
            flash[:alert] = "No result found"
            redirect_to root_path
        end
    end

    def users_list
        @user = params[:search][0].downcase
        @users = User.where( "username like?", "%#{@user}%")
        if @users.size.zero?
            flash[:alert] = "No result found"
            redirect_to root_path
        end
    end

    def books_results
        @book = params[:search][0].downcase
        uri = URI('https://www.googleapis.com/books/v1/volumes')
        params = {:q => @book, :maxResults => 20}
        uri.query = URI.encode_www_form(params)
        @res = Net::HTTP.get_response(uri)
    end
end
