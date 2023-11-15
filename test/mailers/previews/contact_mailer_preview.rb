# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def contact_email
    ContactMailer.with(from: 'test@asdf.com', body: 'AHHH').contact_email
  end
end
