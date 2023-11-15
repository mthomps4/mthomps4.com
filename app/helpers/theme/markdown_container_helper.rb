# frozen_string_literal: true

module Theme
  module ButtonHelper
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
      'w-full p-4 rounded-lg break-words prose prose-sm sm:prose-base prose-brand-blue dark:prose-invert prose-img:rounded-lg hover:prose-a:text-brand-key-lime-200 bg-gradient-to-br from-brand-blue-50 to-brand-blue-100 dark:from-brand-blue-800 dark:to-brand-blue-950 border-[1px] border-brand-blue-300 dark:border-brand-blue-600 text-brand-blue-950 dark:text-brand-blue-100'
    end
  end
end
