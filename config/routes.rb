Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations'}
  get '/profile' => 'home#profile', :as =>'profile'

  get '/ads_list' => 'home#ads_list', :as => 'ads_list'
  get '/users_list' => 'home#users_list', :as => 'users_list'
  get '/books_results' => 'home#books_results', :as => 'books_results'

  devise_scope :user do
    post '/users_list/:id_banned', to: 'users/registrations#banned_user', :as => 'banned_user'
    post '/user_list/:id_admin', to: 'users/registrations#admin_user', :as => 'admin_user'
  end

  root :to => "home#welcome"
  #get '*path' => redirect('/') DA LASCIARE

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
