Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'home#home'
  devise_for :users

  resources :schedules, only: :show

  resources :terms, only: :show
end
