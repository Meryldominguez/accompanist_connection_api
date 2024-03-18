# frozen_string_literal: true

Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'

  scope '/api' do
    resources :profiles, only: %i[index show]
    resources :instruments, only: %i[index show]
    resources :users, only: %i[index show destroy create update]
    resources :user_roles, only: []
    resources :roles, only: []
  end
  scope '/confirm' do
    post '/resend', to: 'confirmations#resend', as: 'resend_confirmation'
    post '/', to: 'confirmations#confirm', as: 'confirm', param: :confirmation_token
  end
  scope '/auth' do
    post '/current_user', to: 'auth#index', as: 'current_user'
    post '/login', to: 'auth#login', as: 'login'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'application#index'
  get '*path', to: 'application#index'
end
