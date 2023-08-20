class Tag < ApplicationRecord
  validates :name, uniqueness: true

  has_many :learnings_tags, dependent: :destroy
  has_many :learnings, through: :learnings_tags

  has_many :posts_tags, dependent: :destroy
  has_many :posts, through: :posts_tags
end
