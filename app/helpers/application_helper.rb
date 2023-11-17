# frozen_string_literal: true

module ApplicationHelper
  include ThemeHelper

  def s3_public_url(s3_url = '')
    s3_url.split('?').first
  end

  def s3_markdown_link(s3_url = '')
    link = s3_public_url(s3_url)
    "![image](#{link})"
  end
end
