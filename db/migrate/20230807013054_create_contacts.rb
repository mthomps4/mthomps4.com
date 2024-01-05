# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[7.0]
  def change
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
