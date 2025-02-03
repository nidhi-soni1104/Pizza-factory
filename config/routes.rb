Rails.application.routes.draw do
  get '/menu', to: 'menu#index'
  
  resources :orders, only: [:create, :show] do
    member do
      patch :cancel
    end
  end

  post '/inventory/restock', to: 'inventory#restock'

  namespace :vendor do
    resources :pizza_menus, only: [:create, :update]
    resources :toppings, only: [:create, :update]
    resources :sides, only: [:create, :update]
  end
end
