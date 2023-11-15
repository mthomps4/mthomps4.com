# frozen_string_literal: true

class PostPublishedOnNullable < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :published_on, :datetime, null: true
  end
end
