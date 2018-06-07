class HomeController < ApplicationController
    #utenti non registrati possono accedere alla pagina welcome e ads_list
    skip_before_action :authenticate_user!, :only => [:welcome, :ads_list]

    def welcome
        #@matches_ads = lista annunci 'vicini'
        #@title = titolo da mostrare 
        if current_user
            user = current_user
            ads_not_user = Ad.where.not(:user_id => user.id)
            #cerco i matches cap/radius da mostrare in home
            @matches_ads = home_ads(ads_not_user)
            @title = "Recent ads close to me"
            if @matches_ads.empty?
                #se non risultano matches passo tutti gli annunci e cambio titolo
                @matches_ads = Ad.all
                @title = "Recent ads"
            end
        else
            @matches_ads = Ad.all
            @title = "Recent ads"
        end
    end
    
    def profile
        @user = User.find(params[:id])
        @chats = @user.chats
        @aux = {} # serve per memorizzare l'altro utente della chat
                  # all'interno della view
        #@c = @user.chats.first

        #per visualizzare la mappa cap
        maps_key = "AIzaSyDGDP6T-EYABI8GMdbuujMJKaCm37fyBss"
        @uri = URI("https://maps.googleapis.com/maps/api/staticmap")
        params = {"center" => "#{@user.cap} italy", "size" => "200x200", "zoom" => "11","key" => "#{maps_key}"}
        @uri.query = URI.encode_www_form(params)
    end

    def admin_panel
        if current_user.role == 'booklover'
            redirect_to root_path, :flash => { :error => "you haven't permission" }
        end
    end

    def ads_list
        @ad = params[:search][0]
        @ads = Ad.where( "book_title iLIKE?", "%#{@ad}%") #ORDINARE?
        if @ads.size.zero?
            flash[:alert] = "No result found"
            redirect_to root_path
        end
    end

    def users_list
        @user = params[:search][0] 
        @users = User.where( "username iLIKE?", "%#{@user}%") #ORDINARE?
        if @users.size.zero?
            flash[:alert] = "No result found"
            redirect_to root_path
        end
    end

    def books_results
        book = params[:search][0].downcase   #uso il downcase per eliminare le ricerche case-sensitive
        uri = URI('https://www.googleapis.com/books/v1/volumes')
        params = {:q => book, :maxResults => 24}
        uri.query = URI.encode_www_form(params)
        @res = Net::HTTP.get_response(uri)
        if JSON.parse(@res.body)['error']  #controllo se l'utente prova a fare una ricerca senza passare parametri
            flash[:alert] = "You should enter something!"
            redirect_to profile_path(current_user.id)
        end
    end

    private
    #per costruire l'array di annunci vicini
    def home_ads(ads_not_user)
        @matches_ads = Array.new
        ads_not_user.all.each  do |ad|
            if Ad.matches_user(ad, current_user.id)
                @matches_ads.push(ad)
            end
        end
        return @matches_ads
    end

end
