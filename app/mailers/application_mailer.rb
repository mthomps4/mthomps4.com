# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default to: "matthew.thompson.a@gmail.com"
  layout "mailer"
end
