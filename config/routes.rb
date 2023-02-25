Rails.application.routes.draw do
  resources :reviews
  resources :recipes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :recipes
  resources :reviews
  get 'upload_file', to: 'sessions#upload_file'
  post 'bulk_add_recipes', to: 'sessions#bulk_add_recipes'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'global_settings_index', to: 'global_settings#index'
  patch 'global_settings_update', to: 'global_settings#update'
  root 'recipes#index'
end
