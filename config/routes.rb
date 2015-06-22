Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount StripeEvent::Engine => '/stripe'

  unauthenticated :user do
    root to: 'playlists#index'
  end

  authenticated :user do
    root :to => 'playlists#index', as: :authenticated_root
  end

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    put 'update_plan', :to => 'users#update_plan'
    put 'update_card', :to => 'users#update_card'
  end

  devise_for :users, controllers: { :registrations => 'registrations', omniauth_callbacks: "omniauth_callbacks" }
  patch '/users/:id/accept_invite', to: "users#accept_invite", as: "accept_invite"
  resources :users
  
  resources :videos

  resources :livestreams do
    resources :comments
  end  
  resources :searches

  resources :playlists do 
    resources :challenges 
  end

  as :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  get 'invitecorner', to: 'management#invitecorner', via: :invitecorner, as: 'invitecorner'

  resources :management do
    collection do
      post 'batch_invite'
    end
  end

  get "/404", :to => "errors#not_found"
  get "/422", :to => "errors#unacceptable"
  get "/500", :to => "errors#internal_error"
  get "/401", :to => "errors#internal_error"

end
