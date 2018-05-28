Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations'}
  get '/users/profile' => 'home#profile', :as =>'profile'

  resources :ads

  get '/ads_list' => 'home#ads_list', :as => 'ads_list'
  get '/books_results' => 'home#books_results', :as => 'books_results'
  get '/users_list' => 'home#users_list', :as => 'users_list'

  devise_scope :user do
    post '/users_list/:id_banned', to: 'users/registrations#banned_user', :as => 'banned_user'
    post '/user_list/:id_admin', to: 'users/registrations#admin_user', :as => 'admin_user'
  end

  post 'send_message', to:'chats#receive'
  get 'send_message', to:'chats#receive'

  mount ActionCable.server, at: '/cable'

  root :to => "home#welcome"
  #get '*path' => redirect('/') DA LASCIARE

end
