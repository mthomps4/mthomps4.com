# frozen_string_literal: true

class PostsController < ApplicationController
  # GET /posts or /posts.json
  def index
    @posts = Post.post.published.order(published_on: :desc)
    @title = 'Posts'
  end

  def til
    @posts = Post.til.published.order(published_on: :desc)
    @title = 'Today I Learned'
    render :index
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @markdown = PostsHelper.render_markdown(@post.content)
  end
end
