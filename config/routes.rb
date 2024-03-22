Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

Rails.application.routes.draw do
  resources :books
end

Rails.application.routes.draw do
  resources :category
end

end
