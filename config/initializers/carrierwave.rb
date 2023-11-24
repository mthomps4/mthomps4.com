# frozen_string_literal: true

# https://github.com/carrierwaveuploader/carrierwave-aws/tree/master

CarrierWave.configure do |config|
  config.storage = :aws
  config.aws_bucket = Rails.application.credentials.dig(:aws, :bucket)
  # config.aws_acl = 'private'
  config.aws_acl = :public_read # Set the ACL for uploaded files

  config.aws_credentials = {
    access_key_id: Rails.application.credentials.dig(:aws, :key),
    secret_access_key: Rails.application.credentials.dig(:aws, :secret),
    region: Rails.application.credentials.dig(:aws, :region),
    stub_responses: Rails.env.test? # Optional, avoid hitting S3 actual during tests
  }

  # The maximum period for authenticated_urls is only 7 days.
  # config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

  # Set custom options such as cache control to leverage browser caching.
  # You can use either a static Hash or a Proc.
  # config.aws_attributes = -> { {
  #   expires: 1.week.from_now.httpdate,
  #   cache_control: 'max-age=604800'
  # } }
end
