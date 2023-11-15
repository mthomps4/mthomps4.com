# frozen_string_literal: true

require 'aws-sdk-s3'

region = Rails.application.credentials.aws[:region] || 'us-east-2'
credentials = Aws::Credentials.new(Rails.application.credentials.aws[:key], Rails.application.credentials.aws[:secret])

Aws.config.update({
                    region:,
                    credentials:
                  })

main_bucket = Rails.application.credentials.aws[:bucket] || 'check-config'
S3_BUCKET = Aws::S3::Resource.new.bucket(main_bucket)
S3_CLIENT = Aws::S3::Client.new(region:, credentials:)
