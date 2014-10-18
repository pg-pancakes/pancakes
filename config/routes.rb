Rails.application.routes.draw do
  root to: "posts#index"

  resources :posts
  resources :users

  mount Pancakes::Engine, at: "/pg"
end
