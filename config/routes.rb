Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get "home/about" => "home#about"
  get "/users" => "users#index"
  post "/books/create" => "books#create"

  resources :users

  resources :books
end
