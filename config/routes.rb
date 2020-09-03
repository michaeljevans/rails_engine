Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/find',      to: 'search#show'
      end

      namespace :items do
        get '/:id/merchant', to: 'merchant#show'
      end

      resources :merchants, except: [:new, :edit]
      resources :items, except: [:new, :edit]
    end
  end
end
