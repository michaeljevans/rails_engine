Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get '/:id/items',    to: 'items#index'
        get '/find_all',     to: 'search#index'
        get '/find',         to: 'search#show'
        get '/most_revenue', to: 'revenue#index'
        get '/most_items',   to: 'items#most_sold'
      end

      namespace :items do
        get '/:id/merchant', to: 'merchant#show'
        get '/find_all',     to: 'search#index'
        get '/find',         to: 'search#show'
      end

      resources :merchants, except: [:new, :edit]
      resources :items, except: [:new, :edit]
    end
  end
end
