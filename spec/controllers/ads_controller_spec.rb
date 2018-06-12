require 'rails_helper'

RSpec.describe AdsController, :type => :controller do
    before :each do
        @user = FactoryBot.create(:user)
        sign_in @user
    end

    describe "POST create" do

        it "create wish ad" do
            post :create, params: { book: {
                id: {
                    "id": "m-KftFxpQk8C",
                    "volumeInfo": {
                        "title": "Gomorra",
                        "authors": ["Roberto Saviano"],
                        "publisher": "Edizioni Mondadori",
                        "imageLinks": {
                            "smallThumbnail": "http://books.google.com/books/content?id=m-KftFxpQk8C&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                            "thumbnail": "http://books.google.com/books/content?id=m-KftFxpQk8C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
                        }
                    }
                }, :list_type => 0}
            }
            expect(response).to redirect_to(profile_path(@user.id))
            expect(flash[:notice]).to be_present
        end

        it "don't create wish ad" do
            post :create, params: { book: {
                id: {
                    "id": "m-KftFxpQk8C",
                    "volumeInfo": {
                        "title": "Gomorra",
                        "authors": ["Roberto Saviano"],
                        "publisher": "Edizioni Mondadori",
                        "imageLinks": {
                            "smallThumbnail": "http://books.google.com/books/content?id=m-KftFxpQk8C&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                            "thumbnail": "http://books.google.com/books/content?id=m-KftFxpQk8C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
                        }
                    }
                }, :list_type => 0}
            }
            post :create, params: { book: {
                id: {
                    "id": "m-KftFxpQk8C",
                    "volumeInfo": {
                        "title": "Gomorra",
                        "authors": ["Roberto Saviano"],
                        "publisher": "Edizioni Mondadori",
                        "imageLinks": {
                            "smallThumbnail": "http://books.google.com/books/content?id=m-KftFxpQk8C&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                            "thumbnail": "http://books.google.com/books/content?id=m-KftFxpQk8C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
                        }
                    }
                }, :list_type => 0}
            }
            expect(response).to redirect_to(profile_path(@user.id))
            expect(flash[:alert]).to be_present
        end

    end

end