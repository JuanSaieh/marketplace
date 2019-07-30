Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
<<<<<<< HEAD
  get 'index', to: 'users#index'

  resources :products, only: [:index]

  root to: 'products#index'
=======
  resources :users, only: [:index, :new, :create]

  root to: 'users#index'
>>>>>>> Added controller and view file to show user attributes
end
