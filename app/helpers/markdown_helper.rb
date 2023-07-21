require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

class CustomRougeRenderer < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

class MarkdownHelper
  def self.renderer
    @renderer ||= CustomRougeRenderer.new
  end

  def self.markdown
    extensions = {
      autolink: true, tables: true, fenced_code_blocks: true, fenced_code: true, strikethrough: true, superscript: true, underline: true,
      highlight: true, quote: true, footnotes: true, link_attributes: { target: '_blank' }
    }

    @markdown ||= Redcarpet::Markdown.new(renderer, extensions)
  end

  def self.render(text)
    markdown.render(text).html_safe
  end
end
