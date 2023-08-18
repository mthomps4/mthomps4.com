class Post < ApplicationRecord
  def fetch_content
    response = Net::HTTP.get_response(URI.parse(url))

    response.body
  end
end
