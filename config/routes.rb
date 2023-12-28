# frozen_string_literal: true

Rails.application.routes.draw do

  root 'main#index'
  scope module: 'main' do
    get 'about', to: 'main#index', as: 'index'
    get 'blog'
    get 'info'
    get 'post/:id', action: :show_post, as: 'post'
    post 'parse_markdown'
  end

  get '/admin', to: 'admin#index'
  namespace 'admin' do
    resources :posts
    post 'upload_image/:id', to: 'posts#upload_images', as: 'upload_images'
    post 'drag_upload_image/:id', to: 'posts#drag_upload_image', as: 'drag_upload_image'
    get 'refresh_sidebar/:id', to: 'posts#refresh_sidebar', as: 'refresh_sidebar'
    get 'resume', to: 'resume#new'
    post 'resume', to: 'resume#create'
    get 'resumes', to: 'resume#index'
  end

  mount Lookbook::Engine, at: '/lookbook' if Rails.env.development?
end
