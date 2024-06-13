# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :name, uniqueness: true

  has_many :posts_tags, dependent: :destroy
  has_many :posts, through: :posts_tags
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
  end
end
