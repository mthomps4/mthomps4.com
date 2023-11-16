# frozen_string_literal: true

module Theme
  module CheckboxHelper
    module_function

    def validate_options(options)
      {
        css: options[:css].to_s
      }
    end

    def generate_styles(**options)
      validated_options = validate_options(options)

      classes = [
        default_styles,
        validated_options[:css]
      ]

      TW_MERGER.merge(classes.join(' '))
    end

    def default_styles
      'h-4 w-4 rounded border-gray-300 text-brand-blue-600 focus:ring-brand-blue-600'
    end
  end
end
