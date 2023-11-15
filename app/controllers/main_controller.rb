# frozen_string_literal: true

class MainController < ApplicationController
  def parse_markdown
    markdown_string = params[:markdown]
    parsed = MarkdownHelper.render(markdown_string)

    render json: { parsed: }
  end

  def index; end

  def info; end
end
