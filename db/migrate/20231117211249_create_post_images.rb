class CreatePostImages < ActiveRecord::Migration[7.1]
  def change
    create_table :post_images do |t|
      t.string :filename
      t.string :image, null: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
