# frozen_string_literal: true

module Admin
  class PostsController < ApplicationController
    before_action :set_post, only: %i[show edit update destroy]
    layout 'admin/post_sidebar_layout'

    # GET /admin/posts or /admin/posts.json
    def index
      @posts = Post.all
    end

    # GET /admin/posts/1 or /admin/posts/1.json
    def show; end

    # GET /admin/posts/new
    def new
      @post = Post.create_draft
      redirect_to edit_admin_post_path(@post)
    end

    # GET /admin/posts/1/edit
    def edit; end

    # POST /admin/posts or /admin/posts.json
    # New creates a draft -- use Update
    # def create
    #   @post = Post.new(post_params)

    #   respond_to do |format|
    #     if @post.save
    #       format.html { redirect_to admin_post_url(@post), notice: "Post was successfully created." }
    #       format.json { render :show, status: :created, location: @post }
    #     else
    #       format.html { render :new, status: :unprocessable_entity }
    #       format.json { render json: @post.errors, status: :unprocessable_entity }
    #     end
    #   end
    # end

    # PATCH/PUT /admin/posts/1 or /admin/posts/1.json
    def update
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to admin_post_url(@post), notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/posts/1 or /admin/posts/1.json
    def destroy
      @post.destroy

      respond_to do |format|
        format.html { redirect_to admin_posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def upload_images
      @post = Post.find(params[:id])
      return unless @post

      @post.update(upload_image_params)
      @post.reload

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post, notice: 'Images were successfully uploaded.' }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      @markdown = PostsHelper.render_markdown(@post.content)
    end

    def upload_image_params
      params.require(:post).permit(images: [])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :content, :published, :post_type, :featured_image)
    end
  end
end
