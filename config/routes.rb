# -*- encoding : utf-8 -*-
Rails.application.routes.draw do
  resources :langs
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

      resources :fuel_types

      resources :langs do
        resources :regions
        resources :cities
      end

      resources :countries do
        resources :regions do
          resources :cities do
            resources :prices
          end
        end
      end
    end
  end

end
