# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_27_023439) do

  create_table "playlist_song_relationships", force: :cascade do |t|
    t.integer "playlist_id"
    t.integer "song_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_id", "song_id"], name: "index_playlist_song_relationships_on_playlist_id_and_song_id", unique: true
    t.index ["playlist_id"], name: "index_playlist_song_relationships_on_playlist_id"
    t.index ["song_id"], name: "index_playlist_song_relationships_on_song_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "difficulty"
    t.integer "plays", default: 0
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_playlists_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_playlists_on_user_id"
  end

  create_table "songs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "song_title"
    t.string "song_artist"
    t.string "song_type"
    t.string "source"
    t.integer "source_period"
    t.string "url"
    t.integer "popularity"
  end

  create_table "user_playlists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "playlist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_id"], name: "index_user_playlists_on_playlist_id"
    t.index ["user_id", "playlist_id"], name: "index_user_playlists_on_user_id_and_playlist_id", unique: true
    t.index ["user_id"], name: "index_user_playlists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
