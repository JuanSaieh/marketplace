Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'index', to: 'users#index'

  resources :products, only: [:index]

  root to: 'products#index'
end
