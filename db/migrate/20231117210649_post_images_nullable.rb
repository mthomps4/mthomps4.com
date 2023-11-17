class PostImagesNullable < ActiveRecord::Migration[7.1]
  def change
    change_column :posts, :images, :string, array: true, default: [], null: true
  end
end
