# frozen_string_literal: true

class RemoveUrlFromPost < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :url, :string
  end
end
