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
    post 'upload_image/:id', to: 'posts#upload_images', as: 'upload_images'
    post 'drag_upload_image/:id', to: 'posts#drag_upload_image', as: 'drag_upload_image'
    get 'refresh_sidebar/:id', to: 'posts#refresh_sidebar', as: 'refresh_sidebar'
  end

  get 'play', to: 'play#index'
  get 'play/fetch_tags', to: 'play#fetch_tags'
  get 'play/update_tag_selections', to: 'play#update_tag_selections'
  post 'play/submit_tags', to: 'play#submit_tags'

  mount Lookbook::Engine, at: '/lookbook' if Rails.env.development?
end
