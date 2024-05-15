# frozen_string_literal: true

class TestMailer < ApplicationMailer
  default from: Rails.application.credentials.dig(:smtp, :username)
  layout 'mailer'

  def test_email(to)
    @body = 'This is a test email'

    mail(to:, subject: 'Test Email')
  end
end
