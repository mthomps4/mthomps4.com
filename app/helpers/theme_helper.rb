# frozen_string_literal: true

module ThemeHelper
  def button_styles(**)
    Theme::ButtonHelper.generate_styles(**)
  end

  def input_styles(**)
    Theme::InputHelper.generate_styles(**)
  end

  def label_styles(**)
    Theme::LabelHelper.generate_styles(**)
  end

  def text_area_styles(**)
    Theme::TextAreaHelper.generate_styles(**)
  end

  def markdown_container_styles(**)
    Theme::MarkdownContainerHelper.generate_styles(**)
  end

  def checkbox_styles(**)
    Theme::CheckboxHelper.generate_styles(**)
  end
end
