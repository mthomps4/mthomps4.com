# frozen_string_literal: true

class Collection < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :posts, dependent: :nullify
end
