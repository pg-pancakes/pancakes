Rails.application.routes.draw do
  root to: "public#landing"

  get "landing", to: "public/landing"
  resources :posts
  resources :users

  mount Pancakes::Engine, at: "/pg"
end
