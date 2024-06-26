# frozen_string_literal: true

module Theme
  module LabelHelper
    module_function

    SIZE = {
      sm: :sm,
      md: :md,
      lg: :lg,
      xl: :xl
    }.freeze

    def size_styles(size)
      {
        SIZE[:sm] => 'px-2.5 py-1.5 text-xs',
        SIZE[:md] => 'px-3 py-2 text-sm',
        SIZE[:lg] => 'px-4 py-2 text-sm',
        SIZE[:xl] => 'px-4 py-2 text-base'
      }[size] || ''
    end

    def validate_options(options)
      {
        size: SIZE[options[:size]&.to_sym] || SIZE[:md],
        css: options[:css].to_s
      }
    end

    def generate_styles(**options)
      validated_options = validate_options(options)

      classes = [
        default_styles,
        size_styles(validated_options[:size]),
        validated_options[:css]
      ]
      TW_MERGER.merge(classes.join(' '))
    end

    def default_styles
      'block text-sm font-medium leading-6 text-brand-blue-900 dark:text-brand-blue-100'
    end
  end
end
