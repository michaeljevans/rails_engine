Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get '/:id/items',    to: 'items#index'
        get '/most_items',   to: 'items#most_sold'
        get '/find_all',     to: 'search#index'
        get '/find',         to: 'search#show'
        get '/most_revenue', to: 'revenue#index'
      end

      namespace :items do
        get '/:id/merchant', to: 'merchant#show'
        get '/find_all',     to: 'search#index'
        get '/find',         to: 'search#show'
      end

      resources :merchants, except: [:new, :edit]
      resources :items, except: [:new, :edit]

      get '/revenue', to: 'revenue#between_dates'
    end
  end
end
