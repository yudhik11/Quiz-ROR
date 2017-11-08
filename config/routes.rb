Rails.application.routes.draw do
  resources :hollywoods
  resources :bollywoods
  resources :footballs
  resources :crickets
  resources :leaderboards
  get 'home/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' ,registrations: 'users/registrations' }
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
