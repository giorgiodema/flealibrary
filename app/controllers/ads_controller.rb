class AdsController < ApplicationController
    def new
        
    end

    def create
        #render plain: @item = params[:book]['id']
        book = params[:book][:id]

        info = {list_type: 'list_type',
                book_title: 'book_title',
                book_authors: 'book_authors',
                link_to_coverbook: 'link_to_coverbook',
                publisher: 'publisher',
                identifier: 'identifier',
                user_id: 'user_id'}
        
        info['user_id'] = current_user.id

        if book['volumeInfo']['imageLinks']

            if book['volumeInfo']['imageLinks']['thumbnail']
                    info['link_to_coverbook'] = book['volumeInfo']['imageLinks']['thumbnail']
            elsif book['volumeInfo']['imageLinks']['smallThumbnail'] 
                    info['link_to_coverbook'] = book['volumeInfo']['imageLinks']['smallThumbnail']
            end

        end 
        
        if book['volumeInfo']['title']

            info['book_title'] = book['volumeInfo']['title']
        #else                DECIDERE SE INSERIRE NULL O STRINGA VUOTA NEL CASO
            #title = ''      NON CI SIA L'ELEMEMTO PER ORA INSERISCO STRINGA VUOTA
        
        end 
        
        if book['volumeInfo']['authors']

            autori = []
            book['volumeInfo']['authors'].each do |author| 
                autori.push(author)
            end
            info['book_authors'] = autori

        end 
        
        if book['volumeInfo']['publisher']

            info['publisher'] = book['volumeInfo']['publisher'] 
         
        end 
        if book['volumeInfo']['industryIdentifiers']

            identificatore = []
            if book['volumeInfo']['industryIdentifiers'][0]['type'] 
                identificatore.push(book['volumeInfo']['industryIdentifiers'][0]['type'])
            end 
            if book['volumeInfo']['industryIdentifiers'][0]['identifier'] 
            identificatore.push(book['volumeInfo']['industryIdentifiers'][0]['identifier'])
            end
            info['identifier'] = identificatore

        end 

        @ad = Ad.create!(:user_id => info['user_id'], :list_type => '0', :book_title => info['book_title'],
                        :book_authors => info['book_authors'], :link_to_coverbook => info['link_to_coverbook'],
                        :publisher => info['publisher'], :identifier => info['identifier'])
        
        flash[:notice] = "Book added to the list"
        redirect_to profile_path
    end
end
