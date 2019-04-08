Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'
  
  resources :users
  resources :songs
  resources :sources
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :playlists do 
    member do
      get :songs
    end
  end
  resources :playlist_song_relationships, only: [:create, :destroy]

  root 'static_pages#home'

  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'


  get '/trivia', to: 'trivia#index'
  get '/trivia/autocomplete_song_source_name'

  get '/trivia/simple', to: 'trivia#new_simple_game'
  post '/trivia/simplesubmit', to: 'trivia#simple_submit'
  get '/trivia/simplesubmit', to: 'trivia#index'

  get '/trivia/playlistselect', to: 'trivia#playlist_select'
  post '/trivia/playlist/', to: 'trivia#new_playlist_game'
  post '/trivia/playlistsubmit', to: 'trivia#playlist_submit'
  get '/trivia/playlistsubmit', to: 'trivia#index'
  get '/trivia/playlist/', to: 'trivia#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
