class HomeController < ApplicationController
    skip_before_action :authenticate_user!, :only => [:welcome, :ads_list]

    def welcome
    end
    
    def profile
        @user = current_user
        @chats = @user.chats
        #@c = @user.chats.first
    end

    def show_profile  # serve per mostrare il profilo di alti utenti quindi non carico le chat
        id = params[:id]
        @user = User.find_by_id(id)
        render 'home/profile.html.erb' #VEDERE SE ESISTE METODO MIGLIORE
    end

    def ads_list
        @ad = params[:search][0].downcase #uso il downcase per eliminare le ricerche case-sensitive
        @ads = Ad.where( "book_title like?", "%#{@ad}%") #ORDINARE?
        if @ads.size.zero?
            flash[:alert] = "No result found"
            redirect_to root_path
        end
    end

    def users_list
        @user = params[:search][0].downcase #uso il downcase per eliminare le ricerche case-sensitive
        @users = User.where( "username like?", "%#{@user}%") #ORDINARE?
        if @users.size.zero?
            flash[:alert] = "No result found"
            redirect_to root_path
        end
    end

    def books_results
        book = params[:search][0].downcase   #uso il downcase per eliminare le ricerche case-sensitive
        uri = URI('https://www.googleapis.com/books/v1/volumes')
        params = {:q => book, :maxResults => 20}
        uri.query = URI.encode_www_form(params)
        @res = Net::HTTP.get_response(uri)
        if JSON.parse(@res.body)['error']  #controllo se l'utente prova a fare una ricerca senza passare parametri
            flash[:alert] = "You should enter something!"
            redirect_to profile_path
        end
    end
end
