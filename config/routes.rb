Pancakes::Engine.routes.draw do
  root to: redirect('databases')

  resources :databases do
    member do
      post :query
    end
    resources :tables do
      resources :records
    end
    resources :extensions, only: [:create, :destroy]
  end

end
