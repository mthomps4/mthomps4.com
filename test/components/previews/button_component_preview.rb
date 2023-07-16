# frozen_string_literal: true

class ButtonComponentPreview < ViewComponent::Preview
  def default
    render(ButtonComponent.new)
  end
end
