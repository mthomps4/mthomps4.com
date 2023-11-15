# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_231_115_135_555) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum 'post_type', %w[post til]
  create_enum 'post_types', %w[post til]

  create_table 'contacts', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'email'
    t.string 'phone_number'
    t.text 'message'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_contacts_on_email'
    t.index ['first_name'], name: 'index_contacts_on_first_name'
    t.index ['last_name'], name: 'index_contacts_on_last_name'
  end

  create_table 'posts', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.text 'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'published_on'
    t.boolean 'published', default: false
    t.enum 'post_type', default: 'post', null: false, enum_type: 'post_types'
    t.string 'featured_image'
    t.index ['published'], name: 'index_posts_on_published'
    t.index ['published_on'], name: 'index_posts_on_published_on'
    t.index ['title'], name: 'index_posts_on_title'
  end

  create_table 'posts_tags', force: :cascade do |t|
    t.bigint 'post_id', null: false
    t.bigint 'tag_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['post_id'], name: 'index_posts_tags_on_post_id'
    t.index ['tag_id'], name: 'index_posts_tags_on_tag_id'
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_tags_on_name', unique: true
  end

  add_foreign_key 'posts_tags', 'posts'
  add_foreign_key 'posts_tags', 'tags'
end
