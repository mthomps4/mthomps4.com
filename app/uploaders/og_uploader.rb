# frozen_string_literal: true

class OgUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :aws

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{model.class.to_s.underscore}/#{model.id}/og"
  end

  def asset_host
    'https://dev-assets.mthomps4.com'
  end

  version :og do
    process resize_to_fill: [1200, 630]
    process :add_text_overlay
  end

  def extension_allowlist
    %w[jpg jpeg gif png]
  end

  def filename
    "og.#{file.extension}"
  end

  private

  def add_text_overlay
    title = title_text
    # title = title_text.gsub(/'/, '\\\\\'') # Escape single quotes in the title

    manipulate! do |img|
      img.combine_options do |c|
        c.gravity 'Center'
        c.pointsize 50
        c.draw "text 0,0 '#{title}'"
        c.fill 'white'
      end
    end
  end

  def title_text
    if model.present? && model.respond_to?(:title)
      model.title
    elsif title.present?
      title
    else
      'Draft'
    end
  end

  def manipulate!
    cache_stored_file! unless cached?
    image = ::MiniMagick::Image.open(current_path)
    yield(image)
    image.write(current_path)
  end
end
