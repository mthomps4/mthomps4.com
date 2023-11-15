# frozen_string_literal: true

class UpdatePosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :published_on, :datetime
    add_column :posts, :published, :boolean, default: false
    add_index :posts, :published
    add_index :posts, :published_on
    add_index :posts, :title, unique: true
  end
end
