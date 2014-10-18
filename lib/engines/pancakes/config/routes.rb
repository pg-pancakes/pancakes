Pancakes::Engine.routes.draw do

  root to: redirect("databases")

  resources :databases do
    resources :tables do
    end
  end
end
