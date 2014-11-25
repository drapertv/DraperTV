Rails.application.routes.draw do
  mount StripeEvent::Engine => '/stripe'


  authenticated :user do
    root :to => 'videos#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'visitors#index'
  end

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    put 'update_plan', :to => 'users#update_plan'
    put 'update_card', :to => 'users#update_card'
  end

  devise_for :users, controllers: { :registrations => 'registrations', omniauth_callbacks: "omniauth_callbacks" }
  resources :users
  resources :videos
  resources :quotes

  as :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  resources :videos do
    resources :comments
  end


  get 'tags/:tag', to: 'videos#index', as: :tag
  get 'profile_edit/:id', to: 'users#profile_edit', as: :profile_edit, via: :all
  get 'profile/:id', to: 'users#profile', as: :profile


end
