# frozen_string_literal: true

class Post < ApplicationRecord
  include Taggable
  before_save :set_published_on, unless: :new_record? # Don't set on create_draft Post.create!
  after_save :create_backup

  has_many :posts_tags
  has_many :tags, through: :posts_tags
  has_many :post_images, dependent: :destroy

  scope :published, -> { where(published: true) }

  validates :title, presence: true

  mount_uploader :featured_image, FeaturedUploader

  POST_TYPES = [['DIGITAL_FORGE', 'Digital Forge'], ['HAND_TOOL_ARMORY', 'Hand Tool Armory']].freeze

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

    S3_BUCKET.put_object({
                           key: "#{path}/post.md",
                           body: content
                         })

    S3_BUCKET.put_object({
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
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[content created_at description featured_image id id_value post_type published
       published_on title updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[post_images posts_tags tags]
  end
end
