class NotificationsController < ApplicationController

=begin
Non sono state definite le classiche azioni CRUD sul model 'Notificha' perchè le notifiche vengono
create e distrutte automaticamente dal sistema.
Quando un utente aggiunge un campo alla wish_list o alla gift_list il sistema cerca tra gli utenti registrati se qualcuno
è interessato al nuovo annuncio e in caso affermatvo crea una notifica per l'utente.
Se un annuncio in una notifica dovesse essere cancellato verrà automaticamente cancellata anche la notifica.
=end

skip_before_action :authenticate_user!

    def index
        new_ads = Array.new
        old_ads = Array.new
        unless current_user.notifications == nil
            current_user.notifications.each do |n|
                if n.displayed == 0
                    new_ads.push(n.ad)
                    n.displayed = 1
                    n.save
                else
                    old_ads.push(n.ad)
                end
            end
        end

        @sorted_new_ads = new_ads.sort_by { |obj| obj.created_at }
        @sorted_old_ads = old_ads.sort_by { |obj| obj.created_at }

        current_user.notifications_counter = 0
        current_user.save
    end
end
