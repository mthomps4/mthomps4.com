class Post < ApplicationRecord
  include Taggable
  before_save :set_published_on
  after_save :create_backup

  has_many :posts_tags, dependent: :destroy
  has_many :tags, through: :posts_tags

  enum post_type: {post: "post", til: "til"}
  scope :published, -> { where(published: true) }

  validates :title, presence: true, uniqueness: true

  mount_uploader :featured_image, FeaturedUploader

  def set_published_on
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
        title: title,
        description: description,
        type: post_type,
        featured_image: featured_image,
        tags: tags.map(&:name),
        published_on: published_on,
        last_updated_at: updated_at
      }.to_json
    })
  end
end
