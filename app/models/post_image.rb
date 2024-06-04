# frozen_string_literal: true

class PostImage < ApplicationRecord
  belongs_to :post
  mount_uploader :image, ImageUploader

  def cdn_url(type = :raw_image)
    version_keys = image.versions.keys

    uploaded_image = if version_keys.include?(type.to_sym)
                       image.send(type)
                     else
                       image
                     end

    "#{uploaded_image.asset_host}/#{uploaded_image.path}"
  end

  def s3_markdown_link(type = :raw_image)
    link = cdn_url(type)
    "![image](#{link})"
  end
end
