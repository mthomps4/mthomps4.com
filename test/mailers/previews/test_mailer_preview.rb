# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/test_mailer
class TestMailerPreview < ActionMailer::Preview
  def test_email
    @from = Rails.application.credentials.dig(:smtp, :username)
    TestMailer.test_email('m@m.com')
  end
end
