# frozen_string_literal: true

Rails.application.routes.draw do
  resources :contacts, only: [:create]
  resources :posts

  get "main/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "main#index"

  mount Lookbook::Engine, at: "/lookbook" if Rails.env.development?
end
