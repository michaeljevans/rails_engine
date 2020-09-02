Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get  '/merchants',     to: 'merchants#index'
      get  '/merchants/:id', to: 'merchants#show'
      post '/merchants',     to: 'merchants#create'
    end
  end
end
