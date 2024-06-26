# frozen_string_literal: true

module Admin
  class PostsController < AdminController
    before_action :set_post, only: %i[show edit update destroy]
    layout 'admin/post_sidebar_layout', except: [:show]

    # GET /admin/posts or /admin/posts.json
    # rubocop:disable Metrics/AbcSize
    def index
      @q = Post.includes(:tags, :collection).order(published_on: :desc).ransack(params[:q])
      @posts = @q.result(distinct: true).page(params[:page]).per(25)
      @collection_options = Collection.all.map { |collection| [collection.name, admin_posts_path(q: { collection_id_eq: collection.id })] }
      @selected_collection = params[:q] ? admin_posts_path(q: { collection_id_eq: params.dig(:q, :collection_id_eq) }) : nil
      @tag_options = Tag.all.map { |tag| [tag.name, admin_posts_path(q: { tags_id_in: tag.id })] }
      @selected_tag = params[:q] ? admin_posts_path(q: { tags_id_in: params.dig(:q, :tags_id_in) }) : nil
    end
    # rubocop:enable Metrics/AbcSize

    # GET /admin/posts/1 or /admin/posts/1.json
    def show; end

    # GET /admin/posts/new
    def new
      @post = Post.create_draft
      redirect_to edit_admin_post_path(@post)
    end

    # GET /admin/posts/1/edit
    def edit
      @tag_options = Tag.all.map { |tag| [tag.name, tag.id] }
      @selected_tags = @post.tags.pluck(:id)
    end

    # PATCH/PUT /admin/posts/1 or /admin/posts/1.json
    def update
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to admin_post_url(@post), notice: 'Post was successfully updated.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/posts/1 or /admin/posts/1.json
    def destroy
      @post.destroy

      respond_to do |format|
        format.html { redirect_to admin_posts_url, notice: 'Post was successfully destroyed.' }
      end
    end

    def upload_images
      @post = Post.find(params[:id])
      return unless @post

      upload_image_params[:images].map do |image|
        next if image.blank?

        @post.post_images.create(filename: image.original_filename, image:)
      end

      @post.reload

      respond_to do |format|
        format.turbo_stream { render layout: false }
      end
    end

    def drag_upload_image
      @post = Post.find(params[:id])
      return unless @post

      image = params.require(:image)

      post_image = @post.post_images.create(filename: image.original_filename, image:)
      @post.reload

      markdown_link = post_image.s3_markdown_link

      render json: { markdown_link: }
    end

    def refresh_sidebar
      @post = Post.find(params[:id])
      return unless @post

      render turbo_stream: turbo_stream.replace('post-image-sidebar', partial: 'admin/posts/images_sidebar',
                                                                      locals: { post_images: @post.post_images })
    end

    private

    def upload_image_params
      params.require(:post).permit(images: [])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.includes(:tags, :collection).find(params[:id])
      @markdown = PostsHelper.render_markdown(@post.content)
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :content, :published, :post_type, :featured_image,
                                   :published_on, :collection_id, tag_ids: [])
    end
  end
end
