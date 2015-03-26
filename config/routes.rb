Rails.application.routes.draw do

  resources :speakers

  resources :video_features

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount StripeEvent::Engine => '/stripe'

  unauthenticated :user do
    root to: 'visitors#index'
  end


  get '/home', to: 'visitors#home'

  authenticated :user do
    root :to => 'videos#index', as: :authenticated_root
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
  resources :favorites, only: [:index]
  get '/favorites/create', to: 'favorites#create', as: 'create_favorite'
  resources :playlists do 
    resources :challenges do 
      resources :comments
    end
  end

  as :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  resources :videos do
    resources :comments
  end

  resources :videos do
    member do
      get "favit", to: "videos#favIt"
    end
  end

  get '/videos/:id/increment_demand', to: 'videos#increment_demand', as: 'video_increment_demand'
  get 'tags/:tag', to: 'videos#index', as: :tag
  get 'profile_edit/:id', to: 'users#profile_edit', as: :profile_edit, via: :all
  get 'profile/:id', to: 'users#profile', as: :profile

#Management
get 'invitecorner', to: 'management#invitecorner', via: :invitecorner
# get 'batch_invite', to: 'management#batch_invite', via: :batch_invite

resources :management do
  collection do
    post 'batch_invite'
  end
end



end
