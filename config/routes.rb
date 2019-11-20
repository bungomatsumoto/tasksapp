Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  root to: "sessions#new"
  resources :tasks
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
end
