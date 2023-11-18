class RemovePostImages < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :images, :string, array: true, default: [], null: true
  end
end
