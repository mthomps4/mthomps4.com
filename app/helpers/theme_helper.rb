# frozen_string_literal: true

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

  def markdown_container_styles(**options)
    Theme::MarkdownContainerHelper.generate_styles(**options)
  end

  def checkbox_styles(**options)
    Theme::CheckboxHelper.generate_styles(**options)
  end
end
