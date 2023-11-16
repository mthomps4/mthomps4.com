class AddImageAssetsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :images, :string, array: true, default: [], null: false
  end
end
