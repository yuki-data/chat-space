Rails.application.routes.draw do
  devise_for :users
  root to: "groups#index"
  resources :users, only: ["index", "edit", "update"]
  resources :groups, only: ["edit", "update", "new", "create"] do
    resources :messages, only: ["index", "create"]
    namespace :api do
      resources :messages, only: ["index"]
    end
  end
end
