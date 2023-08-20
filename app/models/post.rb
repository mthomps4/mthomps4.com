class Post < ApplicationRecord
  include Taggable
  has_many :tags, as: :taggable
  # Reminder: was looking into Raw GitHub links...
  # Will remove and opt for Postgres/S3
  def fetch_content
    response = Net::HTTP.get_response(URI.parse(url))

    response.body
  end
end
