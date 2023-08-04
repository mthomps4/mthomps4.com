# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  def initialize(id: SecureRandom.uuid, header: 'Modal Header', body: 'Hello World!', success: 'Submit',
                 cancel: 'Cancel', label: 'Click me')
    @id = id
    @header = header
    @body = body
    @success = success
    @cancel = cancel
    @label = label
    super
  end
end
