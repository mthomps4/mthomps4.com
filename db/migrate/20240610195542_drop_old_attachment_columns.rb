class DropOldAttachmentColumns < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :featured_image
    remove_column :posts, :og_image
    remove_column :post_images, :image
  end
end
