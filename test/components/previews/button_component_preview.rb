# frozen_string_literal: true

class ButtonComponentPreview < ViewComponent::Preview
  # Button Component
  # ------------
  # A button for clicking.
  #
  # @param label "The text to display on the button."
  # @param variant [Symbol] select "The variant" { choices: [[Primary, primary], [Red, red]] }
  # @param size [Symbol] select "The size" { choices: [[Small, sm], [Medium, md], [Large, lg]] }
  # @param css "custom tailwind"

  def default(label: 'Dynamic text', size: :md, variant: :primary, css: '')
    render(Button.new(label:, url: 'https://google.com', size:, variant:, css:))
  end
end
