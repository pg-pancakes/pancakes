Pancakes::Engine.routes.draw do

  resources :databases do
    resources :tables do
    end
  end

end
