# frozen_string_literal: true

class Post < ApplicationRecord
  include Taggable
  include ImageHelper

  has_one_attached :featured_image do |attachable|
    attachable.variant :thumb, resize_to_fill: [50, 50], preprocessed: true
    attachable.variant :small_og, resize_to_fill: [300, 157.5], preprocessed: true
    attachable.variant :og, resize_to_fill: [1200, 630], preprocessed: true
  end

  has_one_attached :og_image 
  
  def process_og_image
    # Temporarily download the image to a local file
    tempfile = Tempfile.new(['og_image', '.png'])
    tempfile.binmode
    tempfile.write(og_image.download)
    tempfile.close

    title_text = title.presence || 'Draft'

    # Process the image
    ImageHelper.add_text_overlay(tempfile.path, title_text)

    # Re-attach the processed image
    og_image.attach(io: File.open(tempfile.path), filename: "og_image.png", content_type: og_image.content_type)

    # Ensure to close and unlink the tempfile
    tempfile.unlink
  end

  def set_og_image
    image_path = Rails.root.join('app/assets/images/og-base.png')
    og_image = File.open(image_path)
    self.og_image = og_image
  end

  # Don't set on create_draft Post.create!
  before_save :set_published_on, unless: :new_record?
  before_create :set_og_image
  after_commit :process_og_image, on: [:update], if: :og_attached?
  after_save :create_backup

  has_many :posts_tags, dependent: :nullify
  has_many :tags, through: :posts_tags
  has_many :post_images, dependent: :destroy

  validates :title, presence: true

  scope :published, -> { where(published: true) }

  def og_attached?
    og_image.attached?
  end

  def self.create_draft
    # Set base og_image for future updates
    image_path = Rails.root.join('app/assets/images/og-base.png')
    og_image = File.open(image_path)

    Post.create!(title: 'DRAFT', description: 'Add a description here...', content: 'Write your post here...',
                 published: false, og_image:)
  end

  def set_published_on
    return unless published_on.nil? && published?

    self.published_on = Time.zone.now if published?
  end

  def create_backup # rubocop:disable Metrics/AbcSize
    return unless Rails.configuration.active_storage.service == :amazon

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
    sync_og_image if og_image.present?
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

  def sync_og_image # rubocop:disable Metrics/AbcSize
    S3_CLIENT.copy_object({
                            key: og_image.path.to_s,
                            bucket: S3_BACKUP_BUCKET_NAME,
                            copy_source: "#{S3_CDN_BUCKET_NAME}/#{og_image.path}"
                          })

    og_image.versions.each_key do |version|
      S3_CLIENT.copy_object({
                              key: og_image.send(version).path.to_s,
                              copy_source: "#{S3_CDN_BUCKET_NAME}/#{og_image.send(version).path}",
                              bucket: S3_BACKUP_BUCKET_NAME
                            })
    end
  end

  def og_image_cdn_url
    # og_image.asset_host + '/' + og_image.with_title.path
    # I can't spot where the tempfile names are being generated for path...
    # https://dev.assets.mthomps4.com/post/8/with_title_1718041263-508747333762410-0003-9581/og-base.png

    "#{og_image.asset_host}/post/#{id}/with_title_og.png"
  end

  def recreate_og_image
    # og_image.recreate_versions!
    # We need to trigger a full recreation of the og_image here - versions doesn't work
    image_path = Rails.root.join('app/assets/images/og-base.png')
    og_image = File.open(image_path)
    self.og_image = og_image
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[content created_at description featured_image id id_value post_type published
       published_on title updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[post_images posts_tags tags]
  end
end
