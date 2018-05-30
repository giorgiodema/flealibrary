class AdsController < ApplicationController
    def new
        
    end

    def create
        #render plain: @item = params[:book]['id']
        book = params[:book][:id]
        tipo_lista = params[:book][:list_type]
        info = {list_type: 'list_type',
                book_title: 'book_title',
                book_authors: 'book_authors',
                link_to_coverbook: 'link_to_coverbook',
                publisher: 'publisher',
                identifier: 'identifier',
                user_id: 'user_id'}
        
        info['user_id'] = current_user.id
        info['list_type'] = tipo_lista

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

            autori = []
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

            identificatore = []
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
                        :publisher => info['publisher'], :identifier => info['identifier'])
        
        flash[:notice] = "Book added to the list"
        redirect_to profile_path
    end

    def favourite
        tipo_lista = params[:list_type]
        @favourities = Ad.where(:list_type => tipo_lista)
    end
end
