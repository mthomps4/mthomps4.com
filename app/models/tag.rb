# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :name, uniqueness: true

  has_many :posts_tags, dependent: :destroy
  has_many :posts, through: :posts_tags
end
