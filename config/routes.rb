Rails.application.routes.draw do
  devise_for :users
  root to: "groups#index"
  namespace :api do
    resources :messages, only: ["index"]
  end
  resources :users, only: ["index", "edit", "update"]
  resources :groups, only: ["edit", "update", "new", "create"] do
    resources :messages, only: ["index", "create"]
  end
end
