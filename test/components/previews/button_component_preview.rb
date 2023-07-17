# frozen_string_literal: true

class ButtonComponentPreview < ViewComponent::Preview
  # @!group Sizes

  # Button Component
  # ------------
  # A button for clicking.
  #
  # @param label "The text to display on the button."
  # @param variant [Symbol] select "The variant" { choices: [[Primary, primary], [Secondary, secondary], [Danger, danger]] }
  # @param css "custom tailwind (assummes classes have been used and compiled)"

  def small(label: 'Dynamic text', variant: :primary, css: '')
    render(ButtonComponent.new(label:, url: 'https://google.com', size: :sm, variant:, css:))
  end

  def medium(label: 'Dynamic text', variant: :primary, css: '')
    render(ButtonComponent.new(label:, url: 'https://google.com', size: :md, variant:, css:))
  end

  def large(label: 'Dynamic text', variant: :primary, css: '')
    render(ButtonComponent.new(label:, url: 'https://google.com', size: :lg, variant:, css:))
  end

  def extra_large(label: 'Dynamic text', variant: :primary, css: '')
    render(ButtonComponent.new(label:, url: 'https://google.com', size: :xl, variant:, css:))
  end
  # @!endgroup

  # @!group Primay

  # Button Component
  # ------------
  # A button for clicking.
  #
  # @param label "The text to display on the button."
  # @param size [Symbol] select "The size" { choices: [[xs, xs], [sm, sm], [md, md], [lg, lg], [xl, xl]] }
  # @param css "custom tailwind (assummes classes have been used and compiled)"

  def primary(size: :md, label: 'Dynamic text', css: '')
    render(ButtonComponent.new(label:, url: 'https://google.com', size:, variant: :primary, css:))
  end
  # @!endgroup

  # @!group Secondary

  # Button Component
  # ------------
  # A button for clicking.
  #
  # @param label "The text to display on the button."
  # @param size [Symbol] select "The size" { choices: [[xs, xs], [sm, sm], [md, md], [lg, lg], [xl, xl]] }
  # @param css "custom tailwind (assummes classes have been used and compiled)"

  def secondary(size: :md, label: 'Dynamic text', css: '')
    render(ButtonComponent.new(label:, url: 'https://google.com', size:, variant: :secondary, css:))
  end
  # @!endgroup

  # @!group Danger

  # Button Component
  # ------------
  # A button for clicking.
  #
  # @param label "The text to display on the button."
  # @param size [Symbol] select "The size" { choices: [[xs, xs], [sm, sm], [md, md], [lg, lg], [xl, xl]] }
  # @param css "custom tailwind (assummes classes have been used and compiled)"

  def danger(size: :md, label: 'Dynamic text', css: '')
    render(ButtonComponent.new(label:, url: 'https://google.com', size:, variant: :danger, css:))
  end
  # @!endgroup
end
