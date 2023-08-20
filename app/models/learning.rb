class Learning < ApplicationRecord
  include Taggable
  has_many :learnings_tags, dependent: :destroy
  has_many :tags, through: :learnings_tags
end
