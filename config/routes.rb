Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :merchants, except: [:new, :edit]
      resources :items, except: [:new, :edit]

      namespace :merchants do
        get '/:id/items', to: 'items#index'
      end

      namespace :items do
        get '/:id/merchant', to: 'merchant#show'
      end
    end
  end
end
