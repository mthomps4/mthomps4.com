class CreateResumes < ActiveRecord::Migration[7.1]
  def change
    create_table :resumes do |t|
      t.string :file, null: false

      t.timestamps
    end
  end
end
