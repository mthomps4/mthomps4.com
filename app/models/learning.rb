class Learning < ApplicationRecord
  after_save :create_backup
  include Taggable
  has_many :learnings_tags, dependent: :destroy
  has_many :tags, through: :learnings_tags

  def create_backup
    slug = title.parameterize

    S3_BUCKET.put_object({
      key: "#{slug}/#{slug}.md",
      body: markdown
    })

    S3_BUCKET.put_object({
      key: "#{slug}/meta.json",
      body: {
        tags: tags.map(&:name),
        posted_at: created_at,
        last_updated_at: updated_at
      }.to_json
    })
  end
end
