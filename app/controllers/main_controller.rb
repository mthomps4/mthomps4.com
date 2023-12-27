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

  def blog
    @posts = Post.post.published.order(published_on: :desc)
    @title = 'Posts'
  end

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
