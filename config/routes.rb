require 'sidekiq/web'

Rails.application.routes.draw do
  resources :projects do
    resources :tasks
  end
  resources :discussions do
    resources :posts
  end
  namespace :admin do
    resources :users
    resources :services
    resources :notifications
    resources :announcements
    resources :discussions
    resources :posts
    resources :projects
    resources :tasks
    root to: "users#index"
  end
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end


  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
