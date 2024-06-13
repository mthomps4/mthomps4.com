# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :name, uniqueness: true

  has_many :posts_tags, dependent: :destroy
  has_many :posts, through: :posts_tags

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value name updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[post post_tags]
  end
end
