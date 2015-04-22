Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'home#home'
  devise_for :users
end
