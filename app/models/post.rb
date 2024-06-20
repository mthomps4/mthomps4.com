# frozen_string_literal: true

class Post < ApplicationRecord
  # require 'open-uri'
  include ApplicationHelper
  include Taggable
  mount_uploader :featured_image, FeaturedUploader
  mount_uploader :og_image, OgUploader

  before_save :set_published_on, unless: :new_record?
  after_save :create_backup

  has_many :posts_tags, dependent: :nullify
  has_many :tags, through: :posts_tags
  belongs_to :collection, optional: true
  has_many :post_images, dependent: :destroy

  validates :title, presence: true

  scope :published, -> { where(published: true) }

  def self.create_draft
    Post.create!(title: 'DRAFT', description: 'Add a description here...', content: 'Write your post here...',
                 published: false)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[collection_id content created_at description featured_image id id_value og_image post_type published published_on title updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[collection post_images posts_tags tags]
  end

  def set_published_on
    return unless published_on.nil? && published?

    self.published_on = Time.zone.now if published?
  end

  def create_backup
    path = "post/#{id}"

    S3_BACKUP_BUCKET.put_object({
                                  key: "#{path}/post.md",
                                  body: content
                                })

    S3_BACKUP_BUCKET.put_object({
                                  key: "#{path}/meta.json",
                                  body: {
                                    title:,
                                    description:,
                                    type: post_type,
                                    og_image:,
                                    featured_image:,
                                    tags: tags.map(&:name),
                                    published_on:,
                                    last_updated_at: updated_at
                                  }.to_json
                                })

    sync_featured_image if featured_image.present?
    sync_og_image if og_image.present?
    sync_post_images if post_images.present?
  end

  def sync_featured_image # rubocop:disable Metrics/AbcSize
    if object_exists?(S3_BACKUP_BUCKET_NAME, featured_image.path)
      S3_CLIENT.copy_object({
                              key: featured_image.path.to_s,
                              bucket: S3_BACKUP_BUCKET_NAME,
                              copy_source: "#{S3_CDN_BUCKET_NAME}/#{featured_image.path}"
                            })
    end

    featured_image.versions.each_key do |version|
      next unless object_exists?(S3_BACKUP_BUCKET_NAME, featured_image.send(version).path)

      S3_CLIENT.copy_object({
                              key: featured_image.send(version).path.to_s,
                              copy_source: "#{S3_CDN_BUCKET_NAME}/#{featured_image.send(version).path}",
                              bucket: S3_BACKUP_BUCKET_NAME
                            })
    end
  end

  def sync_og_image
    if object_exists?(S3_BACKUP_BUCKET_NAME, og_image.path)
      S3_CLIENT.copy_object({
                              key: og_image.path.to_s,
                              bucket: S3_BACKUP_BUCKET_NAME,
                              copy_source: "#{S3_CDN_BUCKET_NAME}/#{og_image.path}"
                            })
    end

    og_image.versions.each_key do |version|
      next unless object_exists?(S3_BACKUP_BUCKET_NAME, og_image.send(version).path)

      S3_CLIENT.copy_object({
                              key: og_image.send(version).path.to_s,
                              copy_source: "#{S3_CDN_BUCKET_NAME}/#{og_image.send(version).path}",
                              bucket: S3_BACKUP_BUCKET_NAME
                            })
    end
  end

  def sync_post_images
    post_images.each do |post_image|
      if object_exists?(S3_BACKUP_BUCKET_NAME, post_image.image.path)
        S3_CLIENT.copy_object({
                                key: post_image.image.path.to_s,
                                bucket: S3_BACKUP_BUCKET_NAME,
                                copy_source: "#{S3_CDN_BUCKET_NAME}/#{post_image.image.path}"
                              })
      end

      og_image.versions.each_key do |version|
        next unless object_exists?(S3_BACKUP_BUCKET_NAME, post_image.image.send(version).path)

        S3_CLIENT.copy_object({
                                key: post_image.image.send(version).path.to_s,
                                copy_source: "#{S3_CDN_BUCKET_NAME}/#{post_image.image.send(version).path}",
                                bucket: S3_BACKUP_BUCKET_NAME
                              })
      end
    end
  end

  def object_exists?(bucket, key)
    S3_CLIENT.head_object({ bucket:, key: })
    true
  rescue Aws::S3::Errors::NoSuchKey
    false
  rescue Aws::S3::Errors::NotFound
    false
  end

  def featured_cdn_url(type = :raw_image)
    version_keys = featured_image.versions.keys

    uploaded_image = if version_keys.include?(type.to_sym)
                       featured_image.send(type)
                     else
                       featured_image
                     end

    "#{cdn_asset_host}/#{uploaded_image.path}" if uploaded_image.present? && uploaded_image.path.present?
  end

  def og_image_cdn_url(type = :raw_image)
    version_keys = og_image.versions.keys

    uploaded_image = if version_keys.include?(type.to_sym)
                       featured_image.send(type)
                     else
                       featured_image
                     end

    "#{cdn_asset_host}/#{uploaded_image.path}" if uploaded_image.present? && uploaded_image.path.present?
  end
end
