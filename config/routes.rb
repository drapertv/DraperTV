Rails.application.routes.draw do

  authenticated :user do
      root :to => 'videos#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'visitors#index'
  end

  devise_for :users

  resources :videos
  resources :users







  get 'profile_edit/:id', to: 'users#profile_edit', as: :profile_edit, via: :all
  get 'profile/:id', to: 'users#profile', as: :profile


end
