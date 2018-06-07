require 'net/http'
require 'uri'

class Ad < ApplicationRecord
    belongs_to :user
    validates :user_id, :presence => true
    validates_associated :user
    validates_inclusion_of :list_type, in: 0..2

    #funzione per vedere se due annunci matchano la posizione/raggio
    def self.matches(ad_wish, ad_gift)
        # distance matrix api key
        distance_key = 'AIzaSyDGDP6T-EYABI8GMdbuujMJKaCm37fyBss'

        user_wish = User.find(ad_wish.user_id)
        origin_wish = user_wish.cap

        user_gift = User.find(ad_gift.user_id)
        destination_gift = user_gift.cap

        uri = URI("https://maps.googleapis.com/maps/api/distancematrix/json")
        params = {"origins" => "#{origin_wish} italy", "destinations" => "#{destination_gift} italy", "key" => "#{distance_key}"}
        uri.query = URI.encode_www_form(params)

        response = Net::HTTP.get_response(uri)

        res = JSON.parse(response.body)
        #distanza tra cap di user_wish e cap di user_gift
        distance = res['rows'].first['elements'].first['distance']['value'] #espresso in kilometri

        #se la distanza è minore o uguale al raggio di ricerca di user_wish
        radius_wish = user_wish.radius.to_i*1000 #espresso in kilometri
        if(distance <= radius_wish)
            return true
        else
            return false
        end

    end

end