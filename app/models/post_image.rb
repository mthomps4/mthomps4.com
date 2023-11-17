class PostImage < ApplicationRecord
  belongs_to :post
  mount_uploader :images, ImageUploader

  def self.s3_public_url(s3_url = '')
    s3_url.split('?').first
  end

  def self.s3_markdown_link(s3_url = '')
    link = s3_public_url(s3_url)
    "![image](#{link})"
  end
end
