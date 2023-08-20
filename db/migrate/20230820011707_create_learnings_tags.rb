class CreateLearningsTags < ActiveRecord::Migration[7.0]
  def change
    create_table :learnings_tags do |t|
      t.references :learning, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
