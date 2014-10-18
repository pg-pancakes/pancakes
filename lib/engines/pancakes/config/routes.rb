Pancakes::Engine.routes.draw do

  resources :servers do
    resources :databases do
      resources :tables do
      end
    end
  end

end
