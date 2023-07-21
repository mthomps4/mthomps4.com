# frozen_string_literal: true

module PostsHelper
  include MarkdownHelper

  def self.render_markdown(text)
    MarkdownHelper.render(text)
  end
end
