Rails.application.routes.draw do

  resources :emails

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => 'series#home_page'

  resources :videos
  resources :livestreams
  resources :searches
  resources :series
  get '/speakers', to: 'series#index'
  resources :notifications

  get '/about', to: "pages#about", as: "about"


  get "/404", :to => "errors#not_found"
  get "/422", :to => "errors#unacceptable"
  get "/500", :to => "errors#internal_error"
  get "/401", :to => "errors#internal_error"

  get "/:series_slug", :to => "series#director"

  


end
