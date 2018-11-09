Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :events, only: [:create, :show]

      get '/login', to: 'login#login'
      
      post '/search', to: 'spotify_api#search'

      get '/create', to: 'users#create'
      get '/profile', to: 'users#profile'

      get '/events', to: 'events#get_all_events'
      post '/events/:id', to: 'events#add_song'
      post '/party/search', to: 'events#search'
      post '/party/add-user', to: 'events#add_user'

    end
  end
end
