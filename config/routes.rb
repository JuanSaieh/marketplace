Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products do
    resource :status, only: :update, module: 'products'
  end

  resources :users, except: [:edit, :update]

  root to: 'products#index'

end
