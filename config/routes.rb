Rails.application.routes.draw do
  mount Pancakes::Engine, at: "/db"
end
