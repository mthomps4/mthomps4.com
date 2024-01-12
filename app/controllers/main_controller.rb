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

  def new_contact
    @contact = Contact.new
  end

  def create_contact
    @contact = Contact.new(contact_params)

    if @contact.save
      redirect_to root_path, notice: 'Thank You!'
    else
      redirect_to root_path
    end
  end

  def blog; end

  def digital_forge
    @q = Post.published.ransack(params[:q])
    @posts = @q.result(distinct: true).order(published_on: :desc).page(params[:page]).per(10)
    @title = 'The Digital Forge'
    @search_path = digital_forge_path

    render :blog
  end

  # def hand_tool_armory
  #   @q = Post.hand_tool_armory.published.ransack(params[:q])
  #   @posts = @q.result(distinct: true).order(published_on: :desc).page(params[:page]).per(10)
  #   @title = 'The Hand Tool Armory'
  #   @search_path = hand_tool_armory_path

  #   render :blog
  # end

  def hand_tool_armory; end

  # GET /posts/1 or /posts/1.json
  def show_post
    @post = Post.find(params[:id])
    @markdown = PostsHelper.render_markdown(@post.content)
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone_number, :message)
  end
end
