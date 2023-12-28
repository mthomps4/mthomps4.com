# frozen_string_literal: true

module Theme
  module ButtonHelper
    module_function

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

    def validate_options(options)
      {
        size: SIZE[options[:size]&.to_sym] || SIZE[:md],
        variant: VARIANT[options[:variant]&.to_sym] || VARIANT[:primary],
        css: options[:css].to_s
      }
    end

    def generate_styles(**options)
      validated_options = validate_options(options)

      classes = [
        default_styles,
        size_styles(validated_options[:size]),
        variant_styles(validated_options[:variant]),
        validated_options[:css]
      ]

      TW_MERGER.merge(classes.join(' '))
    end

    def default_styles
      'rounded-md font-semibold text-white shadow-sm focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2'
    end

    def size_styles(size)
      {
        SIZE[:sm] => 'px-2.5 py-1.5 text-xs',
        SIZE[:md] => 'px-3 py-2 text-sm',
        SIZE[:lg] => 'px-4 py-2 text-sm',
        SIZE[:xl] => 'px-4 py-2 text-base'
      }[size] || ''
    end

    def variant_styles(variant)
      {
        VARIANT[:primary] => 'bg-brand-blue-600 hover:bg-brand-blue-700 focus:ring-brand-blue-500 focus-visible:outline-brand-blue-600',
        VARIANT[:secondary] => 'bg-brand-blue-50 hover:bg-brand-blue-200 focus:ring-brand-blue-500 focus-visible:outline-brand-blue-600 text-brand-blue-700 border-[1px] border-brand-blue-700',
        VARIANT[:danger] => 'bg-red-600 hover:bg-red-700 focus:ring-red-500 focus-visible:outline-red-600'
      }[variant] || ''
    end
  end
end
