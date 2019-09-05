Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :products do
    resource :status, only: :update, module: 'products'
  end
  resources :users, except: [:edit, :update]

  root to: 'products#index'
end
