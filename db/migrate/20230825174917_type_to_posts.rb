# frozen_string_literal: true

class TypeToPosts < ActiveRecord::Migration[7.0]
  def change
    create_enum :post_types, %w[post til]
    add_column :posts, :post_type, :post_types, null: false, default: 'post'
  end
end
