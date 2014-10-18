Pancakes::Engine.routes.draw do
  root to: redirect("servers/localhost")
  resources :servers
end
