class CreateLearnings < ActiveRecord::Migration[7.0]
  def change
    create_table :learnings do |t|
      t.string :title
      t.text :markdown
      t.boolean :published
      t.datetime :published_on

      t.timestamps
    end
  end
end
