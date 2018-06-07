class AdsController < ApplicationController
    def new
    end

    def create

        book = params[:book][:id] #prendo il libro che gli passo da Google Books
        tipo_lista = params[:book][:list_type] #prendo il tipo lista perchè mi serve per controllare
        # se il libro (chiave: user_id, google_id e list_type) è già presente nella lista dell'utente
        if Ad.where(:user_id => current_user.id, :google_id => book['id'], :list_type => tipo_lista)[0]
            flash[:alert] = 'Annuncio Già presente nella tua lista!'
            redirect_to profile_path(:id => current_user.id)
        else
        #creo un dizionario con tutti i campi che riempirò man mano con le info del libro,
        #controllando prima se le suddete info sono prsenti. In caso negativo assegno la stinga 'not specified'
            info = {list_type: 'list_type',
                    book_title: 'book_title',
                    book_authors: 'book_authors',
                    link_to_coverbook: 'link_to_coverbook',
                    publisher: 'publisher',
                    identifier: 'identifier',
                    user_id: 'user_id',
                    google_id: 'google_id'}
              
            info['user_id'] = current_user.id
            info['list_type'] = tipo_lista
            info['google_id'] = book['id']  #this 3 attributes form a key for the ads table

            if book['volumeInfo']['imageLinks']
                if book['volumeInfo']['imageLinks']['thumbnail']
                    info['link_to_coverbook'] = book['volumeInfo']['imageLinks']['thumbnail']
                elsif book['volumeInfo']['imageLinks']['smallThumbnail'] 
                    info['link_to_coverbook'] = book['volumeInfo']['imageLinks']['smallThumbnail']
                else
                    info['link_to_coverbook'] = 'not specified'
                end
            end 
                
            if book['volumeInfo']['title']
                info['book_title'] = book['volumeInfo']['title']
            else
                info['book_title'] = 'not specified'
            end 
                
            if book['volumeInfo']['authors']
                autori = [] #ci sono casi in cui ho più di un autore quindi creo una lista
                book['volumeInfo']['authors'].each do |author| 
                    autori.push(author)
                end
                info['book_authors'] = autori
            else
                info['book_authors'] = 'not specified'
            end 
                
            if book['volumeInfo']['publisher']
                info['publisher'] = book['volumeInfo']['publisher'] 
            else
                info['publisher'] = 'not specified'
            end

            if book['volumeInfo']['industryIdentifiers']
                identificatore = [] #l'identificatore è composto dal tipo e dal codice, che 
                #sono contenuti in 2 campi diversi (si potrebbe fare un doppio controllo e poi l'unione delle 2 stringhe)
                if book['volumeInfo']['industryIdentifiers'][0]['type'] 
                    identificatore.push(book['volumeInfo']['industryIdentifiers'][0]['type'])
                end 
                if book['volumeInfo']['industryIdentifiers'][0]['identifier'] 
                    identificatore.push(book['volumeInfo']['industryIdentifiers'][0]['identifier'])
                end
                info['identifier'] = identificatore
            else
                info['identifier'] = 'not specified'
            end 

            @ad = Ad.create!(:user_id => info['user_id'], :list_type => info['list_type'], :book_title => info['book_title'],
                            :book_authors => info['book_authors'], :link_to_coverbook => info['link_to_coverbook'],
                            :publisher => info['publisher'], :identifier => info['identifier'],
                            :google_id => info['google_id'])
            #FARE CONTROLLO PER VEDERE SE LA CREATE VA A BUON FINE
            flash[:notice] = "Book added to the list"
            redirect_to profile_path(:id => info['user_id'])
        end
    end
    
    # Metodi per mostrare le liste
    
    def gift
        tipo_lista = params[:list_type]
        @id = params[:id]
        @gifts = Ad.where(:user_id => @id, :list_type => tipo_lista)
    end

    def wish
        tipo_lista = params[:list_type]
        @id = params[:id]
        @wishes = Ad.where(:user_id => @id, :list_type => tipo_lista)
    end

    def destroy
        id = params[:id]
        ad = Ad.find(id)
        if ad.list_type == 0
            flash[:notice] = 'Ad removed'
            Ad.destroy(id)
            redirect_to wish_list_path(:list_type => 0, :id => ad.user_id)
        else
            flash[:notice] = 'Ad removed'
            Ad.destroy(id)
            redirect_to gift_list_path(:list_type => 1, :id => ad.user_id)
    
        end
    end

end
