Rails.application.routes.draw do
  #imposto controller personalizzati in app/controllers/users invece che quelli di devise
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations',
                                    confirmations: 'users/confirmations',
                                    passwords: 'users/passwords'}

  get '/users/profile/:id' => 'home#profile', :as => 'profile'
  #get '/users/profile/:id' => 'home#show_profile', :as => 'show_profile' #serve l'id?

  get '/admin_panel' => 'home#admin_panel', :as => 'admin_panel'

  resources :ads

  get '/profile/favourite_list' => 'ads#favourite', :as => 'favourite_list'
  get '/profile/wish_list' => 'ads#wish', :as => 'wish_list'
  get '/profile/gift_list' => 'ads#gift', :as => 'gift_list'

  get '/ads_list' => 'home#ads_list', :as => 'ads_list'
  get '/books_results' => 'home#books_results', :as => 'books_results'
  get '/users_list' => 'home#users_list', :as => 'users_list'

  devise_scope :user do
    post '/users_list/banned/:id', to: 'users/registrations#banned_user', :as => 'banned_user'
    post '/users_list/admin/:id', to: 'users/registrations#admin_user', :as => 'admin_user'
    post '/users_list/booklover/:id', to: 'users/registrations#booklover_user', :as => 'booklover_user'
    match 'users/:id' => 'users/registrations#admin_destroy_user', :via => :delete, :as => :admin_destroy_user
  end

  # CHATS_CONTROLLER
  post 'send_message', to:'chats#receive'
  post 'delete_chat', to:'chats#delete_chat'
  post 'create_chat', to:'chats#create_chat'

  mount ActionCable.server, at: '/cable'

  root :to => "home#welcome"
  #get '*path' => redirect('/') DA LASCIARE

  resources :notifications, only: [:index]

end
