# frozen_string_literal: true

require 'aws-sdk-s3'

region = Rails.application.credentials.aws[:region] || 'us-east-2'
credentials = Aws::Credentials.new(Rails.application.credentials.aws[:key], Rails.application.credentials.aws[:secret])

Aws.config.update({
                    region:,
                    credentials:
                  })

S3_CDN_BUCKET_NAME = Rails.application.credentials.aws[:cdn_bucket] || 'check-config'
S3_BACKUP_BUCKET_NAME = Rails.application.credentials.aws[:backup_bucket] || 'check-config-backup'
S3_BACKUP_BUCKET = Aws::S3::Resource.new.bucket(S3_BACKUP_BUCKET_NAME)
S3_CDN_BUCKET = Aws::S3::Resource.new.bucket(S3_CDN_BUCKET_NAME)
S3_CLIENT = Aws::S3::Client.new(region:, credentials:)
