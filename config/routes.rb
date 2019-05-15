Rails.application.routes.draw do

  resources :locations
  resources :places
  devise_for :users
  resources :users
  get 'all_users', to: 'home#all_users'
  post 'home/create' => 'home#create'
  get ':username' => 'users#show'
  get ':username/edit' => 'users#edit'

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
