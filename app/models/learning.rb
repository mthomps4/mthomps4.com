class Learning < ApplicationRecord
  include Taggable
  has_many :tags, as: :taggable
end
