require "resque/server"

Rails.application.routes.draw do
  mount Resque::Server.new, :at => "/resque"

  ActiveAdmin.routes(self)
  root 'home#home'
  devise_for :users

  resources :schedules, only: :show

  resources :terms, only: :show

  resources :offers

  resources :proposed_exchanges, only: [:index, :show] do
    member do
      get :accept
      get :reject
    end
  end
end
