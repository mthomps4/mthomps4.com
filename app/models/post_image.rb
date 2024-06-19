# frozen_string_literal: true

class PostImage < ApplicationRecord
  belongs_to :post
  mount_uploader :image, ImageUploader
  after_save :create_backup

  def cdn_url(type = :raw_image)
    version_keys = image.versions.keys

    uploaded_image = if version_keys.include?(type.to_sym)
                       image.send(type)
                     else
                       image
                     end

    "#{asset_host}/#{uploaded_image.path}"
  end

  def s3_markdown_link(type = :raw_image)
    link = cdn_url(type)
    "![image](#{link})"
  end

  def create_backup
    versions = image.versions.keys

    # Copy the original
    S3_CLIENT.copy_object({
                            bucket: S3_BACKUP_BUCKET_NAME,
                            copy_source: "#{S3_CDN_BUCKET_NAME}/#{image.path}",
                            key: image.path.to_s
                          })

    # Copy versions
    versions.each do |version|
      image_path = image.send(version).path

      S3_CLIENT.copy_object({
                              bucket: S3_BACKUP_BUCKET_NAME,
                              copy_source: "#{S3_CDN_BUCKET_NAME}/#{image_path}",
                              key: image_path.to_s
                            })
    end
  end
end
