class FavouritesController < ApplicationController
    
    def new
    end

    def show
    end

    def create
        ad_id = params[:id][:book]
        if Favourite.where(:user_id => current_user.id, :ad_id => ad_id)[0]
            flash[:alert] = 'Annuncio Già presente nella tua lista!'
            redirect_to profile_path(:id => current_user.id)
        else
            favourite = Favourite.create!(:user_id => current_user.id, :ad_id => ad_id)
            flash[:notice] = "Book added to the list"
            redirect_to profile_path(:id => current_user.id)
        end
    end

    def index
        @favourites = Favourite.where(:user_id => current_user.id)
    end

end
