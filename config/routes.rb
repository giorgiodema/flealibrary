Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'signin', to: 'users#sign_in'
  post 'signin', to: 'users#sign_in'

  get 'profile', to: 'users#profile'

  post 'send_message', to:'chats#receive'
  get 'send_message', to:'chats#receive'

end
