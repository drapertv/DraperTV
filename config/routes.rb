Rails.application.routes.draw do
  resources :videos

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
