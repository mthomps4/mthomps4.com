# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false, default: 'DRAFT'
      t.text :description, default: ''
      t.text :content, default: ''
      t.boolean :published, default: false
      t.date :published_on, null: true
      t.string :featured_image, null: true

      t.timestamps
    end
    add_index :posts, :published
    add_index :posts, :published_on
    add_index :posts, :title
    add_index :posts, :description
  end
end
