class OgToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :og_image, :string
  end
end
