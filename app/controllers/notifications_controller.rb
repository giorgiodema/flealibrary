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
        @ads = Array.new
        current_user.notifications.each do |n|
            @ads.push(n.ad)
        end
    end
end
