module ThemeHelper::ButtonHelper
  SIZE = {
    sm: :sm,
    md: :md,
    lg: :lg,
    xl: :xl
  }.freeze

  VARIANT = {
    primary: :primary,
    secondary: :secondary,
    danger: :danger
  }.freeze

  class << self
    def validate_button_options(options)
      {
        size: SIZE[options[:size]&.to_sym] || SIZE[:md],
        variant: VARIANT[options[:variant]&.to_sym] || VARIANT[:primary],
        custom_css: options[:custom_css].to_s
      }
    end

    def generate_button_styles(options = {})
      TW_MERGER.merge("#{default_styles} #{size_styles(options[:size])} #{variant_styles(options[:variant])} #{options[:custom_css]}")
    end

    def default_styles
      "rounded-md font-semibold text-white shadow-sm focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 "
    end

    def size_styles(size)
      {
        SIZE[:sm] => "px-2.5 py-1.5 text-xs",
        SIZE[:md] => "px-3 py-2 text-sm",
        SIZE[:lg] => "px-4 py-2 text-sm",
        SIZE[:xl] => "px-4 py-2 text-base"
      }[size] || ""
    end

    def variant_styles(variant)
      {
        VARIANT[:primary] => "bg-brand-blue-600 hover:bg-brand-blue-700 focus:ring-brand-blue-500 focus-visible:outline-brand-blue-600",
        VARIANT[:secondary] => "bg-blue-500 hover:bg-blue-700 focus:ring-blue-500 focus-visible:outline-blue-600",
        VARIANT[:danger] => "bg-red-600 hover:bg-red-700 focus:ring-red-500 focus-visible:outline-red-600"
      }[variant] || ""
    end
  end
end