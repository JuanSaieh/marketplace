Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products, except: [:show, :update]

  resources :users, except: [:destroy, :edit, :update]

  root to: 'products#index'
end
