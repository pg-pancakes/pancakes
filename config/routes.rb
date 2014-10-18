Rails.application.routes.draw do
  root to: "users#index"

  resources :users

  mount Pancakes::Engine, at: "/pg"
end
