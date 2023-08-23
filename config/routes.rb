# frozen_string_literal: true

Rails.application.routes.draw do
  resources :learnings, only: %i[index show]
  resources :contacts, only: [:create]
  resources :posts

  get 'index', to: 'main#index'
  get 'info', to: 'main#info'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'main#index'

  namespace 'admin' do
    resources :learnings
  end

  mount Lookbook::Engine, at: '/lookbook' if Rails.env.development?
end
