class PostImagesNaming < ActiveRecord::Migration[7.1]
  def change
    rename_column :post_images, :images, :image
  end
end
