Rails.application.routes.draw do

  resources :emails

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => 'series#home_page'



  get '/videos/update_view_counts', to: 'videos#update_view_counts'
  resources :videos
  resources :livestreams
  resources :student_videos
  resources :searches
  resources :series
  get '/series/:id/videos_form', to: 'series#videos_form'

  post '/featured', to: 'series#update_featured'
  post '/popular', to: 'series#update_popular'
  get '/speakers', to: 'series#index'
  resources :notifications, only: 'create'
  get '/unsubscribe/:unsubscribe_key', to: 'notifications#destroy', as: 'unsubscribe'

  get '/about', to: "pages#about", as: "about"




  get "/404", :to => "errors#not_found"
  get "/422", :to => "errors#unacceptable"
  get "/500", :to => "errors#internal_error"
  get "/401", :to => "errors#internal_error"

  get "/:slug", :to => "slugs#redirector"

end
