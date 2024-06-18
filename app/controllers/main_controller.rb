# frozen_string_literal: true

class MainController < ApplicationController
  def parse_markdown
    markdown_string = params[:markdown]
    parsed = MarkdownHelper.render(markdown_string)

    render json: { parsed: }
  end

  def index; end

  def info
    @resume = Resume.last
  end

  def digital_forge
    @q = Post.published.ransack(params[:q])
    @posts = @q.result(distinct: true).order(published_on: :desc).page(params[:page]).per(10)
    @collection_options = Collection.all.map { |collection| [collection.name, digital_forge_path(q: { collection_id_eq: collection.id })] }
    @selected_collection = params[:q] ? digital_forge_path(q: { collection_id_eq: params.dig(:q, :collection_id_eq) }) : nil
    @tag_options = Tag.all.map { |tag| [tag.name, digital_forge_path(q: { tags_id_in: tag.id })] }
    @selected_tag = params[:q] ? digital_forge_path(q: { tags_id_in: params.dig(:q, :tags_id_in) }) : nil
  end

  def tool_armory; end

  def search_posts
    search_params = params[:q] || ''

    @q = Post.published.ransack(title_or_description_cont: search_params)
    @posts = @q.result(distinct: true).order(published_on: :desc).page(params[:page]).per(10)

    respond_to do |format|
      format.html { render 'shared/_post_search_results', layout: false }
    end
  end

  # GET /posts/1 or /posts/1.json
  def show_post
    @post = Post.find(params[:id])
    @markdown = PostsHelper.render_markdown(@post.content)
  end
end
