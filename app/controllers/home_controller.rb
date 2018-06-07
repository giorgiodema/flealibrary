class HomeController < ApplicationController
    #utenti non registrati possono accedere alla pagina welcome e ads_list
    skip_before_action :authenticate_user!, :only => [:welcome, :ads_list]

    def welcome
        #@matches_ads = lista annunci 'vicini'
        #@title = titolo da mostrare 
        if current_user
            user = current_user
            wish_ad = Ad.where(:user_id => user.id, :list_type => 1)
            ad_not_user = Ad.where.not(:user_id => user.id)
            gift_ad = ad_not_user.where(:list_type => 2)
            #cerco i matches wish/gift da mostrare in home
            @matches_ads = home_ads(wish_ad, gift_ad)
            @title = "Recent ads close to me"
            if @matches_ads.empty?
                #se non risultano matches wish/gift passo tutti gli annunci e cambio titolo
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
        #@c = @user.chats.first

        maps_key = "AIzaSyDGDP6T-EYABI8GMdbuujMJKaCm37fyBss"
        @uri = URI("https://maps.googleapis.com/maps/api/staticmap")
        params = {"center" => "#{@user.cap} italy", "size" => "200x200", "key" => "#{maps_key}"}
        @uri.query = URI.encode_www_form(params)
    end

    #utilizziamo una sola route
    #def show_profile  # serve per mostrare il profilo di alti utenti quindi non carico le chat
    #    id = params[:id]
    #   @user = User.find_by_id(id)
    #    render 'home/profile.html.erb' #VEDERE SE ESISTE METODO MIGLIORE
    #end

    def admin_panel
        if current_user.role == 'booklover'
            redirect_to root_path, :flash => { :error => "you haven't permission" }
        end
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
            redirect_to profile_path(current_user.id)
        end
    end

    private
    #per costruire l'array di annunci vicini
    def home_ads(wish_ad, gift_ad)
        @matches_ads = Array.new
        wish_ad.all.each do |ad_wish|
            ad_match_title = gift_ad.where(:book_title => ad_wish.book_title)
            ad_match_title.all.each do |ad_gift| 
                if Ad.matches(ad_wish, ad_gift)
                    @matches_ads.push(ad_gift)
                end
            end
        end
        return @matches_ads
    end

end
