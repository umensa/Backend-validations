Rails.application.routes.draw do
  resources :customers
  resources :orders
  root to: "customers#index"
end
