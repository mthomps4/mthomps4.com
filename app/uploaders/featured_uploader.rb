# frozen_string_literal: true

class FeaturedUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include ApplicationHelper
  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :aws

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  def asset_host
    cdn_asset_host
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [1200, 630]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :square do
    process resize_to_fill: [300, 300]
  end

  version :large_square do
    process resize_to_fill: [600, 600]
  end

  version :small_og do
    process resize_to_fill: [300, 157.5]
  end

  version :og do
    process resize_to_fill: [1200, 630]
    # process :add_text_overlay
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_allowlist
    %w[jpg jpeg gif png]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "featured.#{file.extension}"
  end
end
