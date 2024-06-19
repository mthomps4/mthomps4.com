# frozen_string_literal: true

class OgUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include ApplicationHelper
  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :aws

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{model.class.to_s.underscore}/#{model.id}"
  end

  def asset_host
    cdn_asset_host
  end

  version :with_title do
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
    title = add_line_breaks_by_words(title, 25)
    # title = title_text.gsub(/'/, '\\\\\'') # Escape single quotes in the title

    manipulate! do |img|
      img.combine_options do |c|
        c.gravity 'Center'
        c.pointsize 60
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

  def add_line_breaks(str, interval = 10)
    str.scan(/.{1,#{interval}}/).join("\n")
  end

  def add_line_breaks_by_words(str, max_length = 10)
    words = str.split
    lines = []
    current_line = ''

    words.each do |word|
      if current_line.length + word.length + 1 <= max_length
        current_line += ' ' unless current_line.empty?
        current_line += word
      else
        lines << current_line
        current_line = word
      end
    end
    lines << current_line unless current_line.empty?

    lines.join("\n")
  end

  def manipulate!
    # base_image_path = Rails.root.join('app/assets/images/og-base.png')
    # cdn_path = "https://dev.assets.mthomps4.com/og-base.png"

    cache_stored_file! unless cached?
    image = ::MiniMagick::Image.open(current_path)
    yield(image)
    image.write(current_path)
  end
end
