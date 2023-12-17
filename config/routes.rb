# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/api' do
    resources :profiles, only: []
    resources :instruments, only: []
    resources :users, only: %i[index show destroy create update]
    resources :user_roles, only: []
    resources :roles, only: []
  end
  scope '/confirm' do
    post '/resend', to: 'confirmations#create', as: 'resend_confirmation'
    post '/', to: 'confirmations#edit', as: 'confirm', param: :confirmation_token
  end
  scope '/auth' do
    post '/login', to: 'auth#login', as: 'login'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
