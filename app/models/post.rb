# frozen_string_literal: true

class Post < ApplicationRecord
  include Taggable
  mount_uploader :featured_image, FeaturedUploader

  before_save :set_published_on, unless: :new_record? # Don't set on create_draft Post.create!
  after_save :create_backup

  has_many :posts_tags, dependent: :nullify
  has_many :tags, through: :posts_tags
  has_many :post_images, dependent: :destroy

  scope :published, -> { where(published: true) }

  # POST_TYPES = { digital_forge: 'Digital Forge', hand_tool_armory: 'Hand Tool Armory' }.freeze
  # enum post_type: POST_TYPES, default: :digital_forge
  # scope :digital_forge, -> { where(post_type: Post.post_types[:digital_forge]) }
  # scope :hand_tool_armory, -> { where(post_type: Post.post_types[:hand_tool_armory]) }

  validates :title, presence: true

  def self.create_draft
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

  def self.ransackable_attributes(_auth_object = nil)
    %w[content created_at description featured_image id id_value post_type published
       published_on title updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[post_images posts_tags tags]
  end
end
