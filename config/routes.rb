Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get    '/merchants',     to: 'merchants#index'
      post   '/merchants',     to: 'merchants#create'
      patch  '/merchants/:id', to: 'merchants#update'
      delete '/merchants/:id', to: 'merchants#destroy'
      get    '/merchants/:id', to: 'merchants#show'

      get    '/items',     to: 'items#index'
      post   '/items',     to: 'items#create'
      patch  '/items/:id', to: 'items#update'
      delete '/items/:id', to: 'items#destroy'
      get    '/items/:id', to: 'items#show'
    end
  end
end
