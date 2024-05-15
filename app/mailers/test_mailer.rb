# frozen_string_literal: true

class TestMailer < ApplicationMailer
  default from: 'test@mthomps4.com'
  layout 'mailer'

  def test_email(to)
    @body = 'This is a test email'

    mail(to:, subject: 'Test Email')
  end
end
