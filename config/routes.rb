Rails.application.routes.draw do
  resources :videos

  devise_for :users
  resources :users


  authenticated :user do
      root :to => 'videos#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'visitors#index'
  end



end
