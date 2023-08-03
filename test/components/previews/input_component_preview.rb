class InputComponentPreview < ViewComponent::Preview
  # Input Component
  # ------------
  # An Input Component.
  #
  # @param label [String] "The text to display on the button."
  # @param type [String] "The type of input to display."
  # @param id [String] "The id of the input."
  # @param placeholder [String] "The placeholder text to display."
  # @param input_styles [String] "Custom tailwind classes (assumes classes have been used and compiled)"
  # @param label_styles [String] "Custom tailwind classes (assumes classes have been used and compiled)"

  def default(id: "input", label: "First Name", type: "text", placeholder: "Peter", input_styles: "", label_styles: "")
    render(InputComponent.new(id: id, label: label, type: type, placeholder: placeholder, options: {input_styles: input_styles, label_styles: label_styles}))
  end
end
