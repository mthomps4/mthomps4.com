class IndexLearnings < ActiveRecord::Migration[7.0]
  def change
    add_index :learnings, :published
    add_index :learnings, :published_on
    add_index :learnings, :title
  end
end
