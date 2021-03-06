# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131003165753) do

  create_table "distances", :force => true do |t|
    t.integer "user_id"
    t.integer "stranger_id"
    t.float   "distance"
  end

  create_table "matches", :force => true do |t|
    t.integer "user_1"
    t.integer "user_2"
    t.string  "user_1_vote"
    t.string  "user_2_vote"
    t.string  "match_status", :default => "Pending"
  end

  create_table "messages", :force => true do |t|
    t.string   "topic"
    t.text     "body"
    t.integer  "received_messageable_id"
    t.string   "received_messageable_type"
    t.integer  "sent_messageable_id"
    t.string   "sent_messageable_type"
    t.boolean  "opened",                     :default => false
    t.boolean  "recipient_delete",           :default => false
    t.boolean  "sender_delete",              :default => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "ancestry"
    t.boolean  "recipient_permanent_delete", :default => false
    t.boolean  "sender_permanent_delete",    :default => false
  end

  add_index "messages", ["ancestry"], :name => "index_messages_on_ancestry"
  add_index "messages", ["sent_messageable_id", "received_messageable_id"], :name => "acts_as_messageable_ids"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "age"
    t.string   "email"
    t.string   "sex"
    t.string   "sex_preference"
    t.string   "tagline"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "password_digest"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.float    "longitude",          :default => 0.0
    t.float    "latitude",           :default => 0.0
  end

  create_table "users_votes", :force => true do |t|
    t.integer "user_id"
    t.integer "vote_id"
  end

  create_table "votes", :force => true do |t|
    t.integer  "voter_id"
    t.integer  "voted_on_id"
    t.string   "opinion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "votes", ["voter_id"], :name => "index_votes_on_voter_id"

end
