class AddUrlToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :url, :string, null: false
    add_index :posts, :url, unique: true
  end
end
