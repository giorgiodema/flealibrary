Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations'}
  get '/profile' => 'home#profile', :as =>'profile'
  root :to => "home#welcome"

  get '/ads_list' => 'home#ads_list', :as => 'ads_list'
  get '/users_list' => 'home#users_list', :as => 'users_list'
  get '/books_results' => 'home#books_results', :as => 'books_results'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
