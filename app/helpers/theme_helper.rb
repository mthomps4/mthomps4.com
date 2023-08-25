module ThemeHelper
  def button_styles(**options)
    Theme::ButtonHelper.generate_styles(**options)
  end

  def input_styles(**options)
    Theme::InputHelper.generate_styles(**options)
  end

  def label_styles(**options)
    Theme::LabelHelper.generate_styles(**options)
  end

  def text_area_styles(**options)
    Theme::TextAreaHelper.generate_styles(**options)
  end

  def markdown_container_styles(css: "")
    base_styles = "w-full my-2 md:my-0 md:w-1/2 p-4 rounded-lg break-words prose prose-sm sm:prose-base prose-brand-blue dark:prose-invert prose-img:rounded-lg hover:prose-a:text-brand-key-lime-200 bg-gradient-to-br from-brand-blue-50 to-brand-blue-100 dark:from-brand-blue-800 dark:to-brand-blue-950 border-[1px] border-brand-blue-300 dark:border-brand-blue-600 text-brand-blue-950 dark:text-brand-blue-100"

    TW_MERGER.merge("#{base_styles} #{css}")
  end

  def checkbox_styles(css: "")
    base_styles = "h-4 w-4 rounded border-gray-300 text-brand-blue-600 focus:ring-brand-blue-600"

    TW_MERGER.merge("#{base_styles} #{css}")
  end
end
