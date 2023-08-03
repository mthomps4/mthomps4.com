# frozen_string_literal: true

class InputComponent < ViewComponent::Base
  def initialize(type:, id:, label:, placeholder: "", options: {})
    @id = id
    @label = label
    @type = type
    @placeholder = placeholder.to_s
    @options = validate_options(options)
    @input_styles = generate_input_styles(@options)
    @label_styles = generate_label_styles(@options)
  end

  private

  def validate_options(options)
    {
      input_styles: options[:input_styles].to_s,
      label_styles: options[:label_styles].to_s
    }
  end

  def generate_input_styles(options)
    TW_MERGER.merge("#{default_input_styles} #{options[:input_styles]}")
  end

  def generate_label_styles(options)
    TW_MERGER.merge("#{default_label_styles} #{options[:label_styles]}")
  end

  def default_input_styles
    "block w-full rounded-md border-0 py-1.5 text-brand-blue-900 shadow-sm ring-1 ring-inset ring-brand-blue-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-brand-blue-600 sm:text-sm sm:leading-6"
  end

  def default_label_styles
    "block text-sm font-medium leading-6 text-brand-blue-900 dark:text-brand-blue-100"
  end
end
