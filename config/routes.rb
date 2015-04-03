Rails.application.routes.draw do
  root 'home#home'
  devise_for :users
end
