# -*- encoding : utf-8 -*-
Rails.application.routes.draw do
  root "pages#index"
  get 'pages/index'

  resources :countries
  resources :prices
  resources :trademarks
  resources :fuel_types
  resources :cities
  resources :regions


  namespace :api, :defaults => { :format => 'json' } do
    namespace :v1 do
      resources :countries do
        resources :regions do
          resources :cities do
            resources :trademarks
          end
        end
      end
    end
  end

end
