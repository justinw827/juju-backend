Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/login', to: 'login#login'
      get '/create', to: 'users#create'
    end
  end
end
