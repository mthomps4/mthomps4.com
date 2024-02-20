class PostCollections < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :collection, foreign_key: true, null: true
  end
end
