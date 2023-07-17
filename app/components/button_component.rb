# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  def initialize(label:, url:, size: :md, variant: :primary, css: '')
    @label = label
    @url = url
    @styles = generate_styles(size, variant, css)
  end

  def generate_styles(size, variant, css)
    TW_MERGER.merge("#{default_styles} #{size_styles(size)} #{variant_styles(variant)} #{css}")
  end

  def default_styles
    'rounded-md font-semibold text-white shadow-sm focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 '
  end

  def size_styles(size)
    {
      sm: 'px-2.5 py-1.5 text-xs',
      md: 'px-3 py-2 text-sm',
      lg: 'px-4 py-2 text-sm',
      xl: 'px-4 py-2 text-base'
    }[size] || ''
  end

  def variant_styles(variant)
    {
      primary: 'bg-indigo-600 hover:bg-indigo-700 focus:ring-indigo-500 focus-visible:outline-indigo-600',
      secondary: 'bg-brand-500 hover:bg-blue-700 focus:ring-blue-500 focus-visible:outline-blue-600',
      danger: 'bg-red-600 hover:bg-red-700 focus:ring-red-500 focus-visible:outline-red-600'
    }[variant] || ''
  end
end
