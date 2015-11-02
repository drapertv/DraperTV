Rails.application.routes.draw do

  resources :emails

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount StripeEvent::Engine => '/stripe'

  unauthenticated :user do
    root to: 'series#index'
  end

  authenticated :user do
    root :to => 'series#index', as: :authenticated_root
  end

  resources :videos

  resources :livestreams do
    resources :comments
  end  
  resources :searches

  resources :series

  get '/hidebanner', to: 'livestreams#hidebanner'



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
