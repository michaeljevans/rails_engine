Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get    '/merchants',     to: 'merchants#index'
      post   '/merchants',     to: 'merchants#create'
      patch  '/merchants/:id', to: 'merchants#update'
      delete '/merchants/:id', to: 'merchants#destroy'
      get    '/merchants/:id', to: 'merchants#show'
    end
  end
end
