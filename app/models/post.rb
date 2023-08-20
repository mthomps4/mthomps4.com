class Post < ApplicationRecord
  include Taggable
  has_many :posts_tags, dependent: :destroy
  has_many :tags, through: :posts_tags
  # Reminder: was looking into Raw GitHub links...
  # Will remove and opt for Postgres/S3
  def fetch_content
    response = Net::HTTP.get_response(URI.parse(url))

    response.body
  end
end
