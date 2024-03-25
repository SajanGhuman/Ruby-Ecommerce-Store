Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'books#index'
  resources :books
  resources :categories do
    resources :books, only: [:index]
  end

  get 'contact', to: 'contact#show'
  get 'about', to: 'about#show'
end
