# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default to: 'example@email.com'
  layout 'mailer'
end
