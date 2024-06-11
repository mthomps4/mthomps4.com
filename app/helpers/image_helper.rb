module ImageHelper
  def self.add_text_overlay(image_path, title = nil)
    title = title.presence || 'DRAFT'
    text_overlay = "text 0,0 '#{title}'"

    manipulate_image(image_path) do |img|
      img.combine_options do |c|
        c.gravity 'Center'
        c.pointsize 50
        c.draw text_overlay
      end
    end
  end

  def self.manipulate_image(image_path)
    # base_image_path = Rails.root.join('app/assets/images/og-base.png')
    # cdn_path = "https://dev.assets.mthomps4.com/og-base.png"
    #
    # cache_stored_file! unless cached?
    image = ::MiniMagick::Image.open(image_path)
    yield(image)
    image.write(image_path)
  end
end
