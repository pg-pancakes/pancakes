Rails.application.routes.draw do
  resources :posts

  root to: "users#index"

  resources :users

  mount Pancakes::Engine, at: "/pg"
end
