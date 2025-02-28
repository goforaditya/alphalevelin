Rails.application.routes.draw do
  root 'pages#index'
  get 'about', to: 'pages#about'
  get 'help-support', to: 'pages#helpsupport'
  resources :posts
  resources :categories

  #user 
  get 'signup', to: 'users#new' 
  resources :users, except: [:new]

  # Private user notes
  resources :notes
  
  #user login & logout
  get 'signin', to: 'sessions#new' 
  post 'signin', to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy'
  
  # OmniAuth routes
  post '/auth/:provider/callback', to: 'omniauth_callbacks#:provider'
  get '/auth/failure', to: redirect('/')
end
