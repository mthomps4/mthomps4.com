class Post < ApplicationRecord
  after_save :create_backup
  include Taggable
  has_many :posts_tags, dependent: :destroy
  has_many :tags, through: :posts_tags

  enum post_type: {post: "post", til: "til"}
  scope :published, -> { where(published: true) }

  def create_backup
    slug = title.parameterize

    S3_BUCKET.put_object({
      key: "#{slug}/#{slug}.md",
      body: content
    })

    S3_BUCKET.put_object({
      key: "#{slug}/meta.json",
      body: {
        title: title,
        description: description,
        # featured_image: featured_image,
        tags: tags.map(&:name),
        published_on: published_on,
        last_updated_at: updated_at
      }.to_json
    })
  end
end
