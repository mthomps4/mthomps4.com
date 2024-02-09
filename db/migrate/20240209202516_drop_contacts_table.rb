class DropContactsTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :contacts
  end

  def down
    # raise ActiveRecord::IrreversibleMigration
    # Technically, this migration is reversible, but there won't be any data to recover.
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.text :message

      t.timestamps
    end

    add_index :contacts, :first_name
    add_index :contacts, :last_name
    add_index :contacts, :email
    add_index :contacts, :phone_number
  end
end
