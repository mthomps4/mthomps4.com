# frozen_string_literal: true

class Post < ApplicationRecord
  # require 'open-uri'

  include Taggable
  mount_uploader :featured_image, FeaturedUploader
  # mount_uploader :og_image, OgUploader

  # Don't set on create_draft Post.create!
  before_save :set_published_on, unless: :new_record?
  # before_save :recreate_og_image, unless: :new_record?
  after_save :create_backup

  has_many :posts_tags, dependent: :nullify
  has_many :tags, through: :posts_tags
  belongs_to :collection, optional: true
  has_many :post_images, dependent: :destroy

  validates :title, presence: true

  scope :published, -> { where(published: true) }

  def self.create_draft
    # Set base og_image for future updates
    # image_path = Rails.root.join('app/assets/images/og-base.png')
    # og_image = File.open(image_path)

    Post.create!(title: 'DRAFT', description: 'Add a description here...', content: 'Write your post here...',
                 published: false)
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
                                    featured_image:,
                                    tags: tags.map(&:name),
                                    published_on:,
                                    last_updated_at: updated_at
                                  }.to_json
                                })

    sync_featured_image if featured_image.present?
    # sync_og_image if og_image.present?
  end

  def sync_featured_image # rubocop:disable Metrics/AbcSize
    S3_CLIENT.copy_object({
                            key: featured_image.path.to_s,
                            bucket: S3_BACKUP_BUCKET_NAME,
                            copy_source: "#{S3_CDN_BUCKET_NAME}/#{featured_image.path}"
                          })

    featured_image.versions.each_key do |version|
      S3_CLIENT.copy_object({
                              key: featured_image.send(version).path.to_s,
                              copy_source: "#{S3_CDN_BUCKET_NAME}/#{featured_image.send(version).path}",
                              bucket: S3_BACKUP_BUCKET_NAME
                            })
    end
  end

  # def sync_og_image
  #   S3_CLIENT.copy_object({
  #                           key: og_image.path.to_s,
  #                           bucket: S3_BACKUP_BUCKET_NAME,
  #                           copy_source: "#{S3_CDN_BUCKET_NAME}/#{og_image.path}"
  #                         })
  #
  #   og_image.versions.each_key do |version|
  #     S3_CLIENT.copy_object({
  #                             key: og_image.send(version).path.to_s,
  #                             copy_source: "#{S3_CDN_BUCKET_NAME}/#{og_image.send(version).path}",
  #                             bucket: S3_BACKUP_BUCKET_NAME
  #                           })
  #   end
  # end
  #
  # def og_image_cdn_url
  #   # og_image.asset_host + '/' + og_image.with_title.path
  #   # I can't spot where the tempfile names are being generated for path...
  #   # https://dev.assets.mthomps4.com/post/8/with_title_1718041263-508747333762410-0003-9581/og-base.png
  #
  #   "#{og_image.asset_host}/post/#{id}/with_title_og.png"
  # end
  #
  # def recreate_og_image
  #   # og_image.recreate_versions!
  #   # We need to trigger a full recreation of the og_image here - versions doesn't work
  #   image_path = Rails.root.join('app/assets/images/og-base.png')
  #   og_image = File.open(image_path)
  #   self.og_image = og_image
  # end

  def self.ransackable_attributes(_auth_object = nil)
    %w[collection_id content created_at description featured_image id id_value og_image post_type published published_on title updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[collection post_images posts_tags tags]
  end
end
