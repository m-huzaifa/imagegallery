Rails.application.routes.draw do
 
  get 'visitors/index'
  root to: 'visitors#index'
  
 # devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  

  devise_for :users, controllers: { registrations: "registrations" } do 
  	match "users/sign_out", to: "devise/sessions#destroy", via: :delete
  end
  resources :users do
    match "/new_gallery", to: "users#new_gallery", via: :get
    match "", to: "users#create_gallery", via: :patch
  end

  resources :attachments
  get "all_attachments", to: "attachments#all_attachments"
  get "/:id/gallery", to: "attachments#gallery", as: "gallery"
  resources :roles
  resources :orders
  post "orders/orders/new", to: "orders#create"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
