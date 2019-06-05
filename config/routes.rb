Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :places, only: [:create, :show]
  get 'all_users', to: 'home#all_users'
  get ':username' => 'users#show'
  get ':username/edit' => 'users#edit'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
