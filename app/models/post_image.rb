class PostImage < ApplicationRecord
  belongs_to :post
  mount_uploaders :images, ImageUploader
  # https://github.com/carrierwaveuploader/carrierwave#skipping-activerecord-callbacks
  # skip_callback :commit, :after, :remove_images!

  def self.s3_public_url(s3_url = '')
    s3_url.split('?').first
  end

  def self.s3_markdown_link(s3_url = '')
    link = s3_public_url(s3_url)
    "![image](#{link})"
  end
end
