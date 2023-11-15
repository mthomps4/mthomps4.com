# frozen_string_literal: true

json.extract! post, :id, :title, :description, :content, :created_at, :updated_at
json.url post_url(post, format: :json)
