Rails.application.routes.draw do
  root to: "users#index"

  devise_for :users
  resources :users

  mount Pancakes::Engine, at: "/db"
end
