# frozen_string_literal: true

Rails.application.routes.draw do
  resources :contacts, only: [:create]
  resources :posts, only: %i[index show]
  get 'til', to: 'posts#til'

  get 'index', to: 'main#index'
  get 'info', to: 'main#info'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'main#index'
  post 'parse_markdown', to: 'main#parse_markdown'

  namespace 'admin' do
    resources :posts
  end

  mount Lookbook::Engine, at: '/lookbook' if Rails.env.development?
end
