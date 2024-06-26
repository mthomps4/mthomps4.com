class CreateCollections < ActiveRecord::Migration[7.1]
  def change
    create_table :collections do |t|
      t.string :name

      t.timestamps
    end
    add_index :collections, :name, unique: true
  end
end
