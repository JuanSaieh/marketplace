Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products, only: [:index]

  resources :users, only: [:index, :new, :create]

  root to: 'users#index'
end
