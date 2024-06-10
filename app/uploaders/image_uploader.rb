# frozen_string_literal: true

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :aws

  def store_dir
    Rails.logger.info("\n\n\n #{model} -- #{mounted_as}")
    "post/#{model.post_id}/#{mounted_as.to_s.pluralize}"
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :small_og do
    process resize_to_fill: [300, 157.5]
  end

  version :og do
    process resize_to_fill: [1200, 630]
  end

  def asset_host
    'https://dev.assets.mthomps4.com'
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_allowlist
    %w[jpg jpeg gif png]
  end
end
