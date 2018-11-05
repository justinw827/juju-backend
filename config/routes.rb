Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :events, only: [:create]
      
      get '/login', to: 'login#login'
      get '/create', to: 'users#create'
      get '/events', to: 'events#get_all_events'
    end
  end
end
