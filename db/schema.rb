# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110307082432) do

  create_table "categories", :force => true do |t|
    t.string   "title",       :limit => 64,                 :null => false
    t.string   "keywords",    :limit => 128,                :null => false
    t.string   "description", :limit => 256,                :null => false
    t.integer  "status_id",                  :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["title"], :name => "index_categories_on_title", :unique => true
  add_index "categories", ["status_id"], :name => "status_id"

  create_table "categories_posts", :id => false, :force => true do |t|
    t.integer "category_id", :null => false
    t.integer "post_id",     :null => false
  end

  add_index "categories_posts", ["post_id"], :name => "post_id"

  create_table "comments", :force => true do |t|
    t.string   "user_name",  :limit => 24,                 :null => false
    t.string   "email",      :limit => 64,                 :null => false
    t.string   "website",    :limit => 128
    t.text     "body",                                     :null => false
    t.integer  "post_id",                                  :null => false
    t.integer  "status_id",                 :default => 1, :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], :name => "post_id"
  add_index "comments", ["status_id"], :name => "status_id"
  add_index "comments", ["user_id"], :name => "user_id"

  create_table "menu", :force => true do |t|
    t.string   "key",        :limit => 32,  :null => false
    t.string   "name",       :limit => 128, :null => false
    t.string   "url",        :limit => 128, :null => false
    t.integer  "status_id",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menu", ["key"], :name => "index_menu_on_key", :unique => true
  add_index "menu", ["name"], :name => "index_menu_on_name", :unique => true
  add_index "menu", ["url"], :name => "index_menu_on_url", :unique => true
  add_index "menu", ["status_id"], :name => "status_id"

  create_table "pages", :force => true do |t|
    t.string   "title",       :limit => 64,                 :null => false
    t.string   "keywords",    :limit => 128,                :null => false
    t.string   "description", :limit => 256,                :null => false
    t.string   "url",         :limit => 32,                 :null => false
    t.text     "body"
    t.integer  "status_id",                  :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["url"], :name => "index_pages_on_url", :unique => true
  add_index "pages", ["status_id"], :name => "status_id"

  create_table "posts", :force => true do |t|
    t.string   "title",                :limit => 128,                 :null => false
    t.string   "title_transliterated", :limit => 256,                 :null => false
    t.string   "keywords",             :limit => 128,                 :null => false
    t.string   "description",          :limit => 1024,                :null => false
    t.text     "body",                                                :null => false
    t.integer  "status_id",                            :default => 1, :null => false
    t.integer  "hits",                                 :default => 0, :null => false
    t.integer  "rating",                               :default => 0, :null => false
    t.integer  "user_id",                              :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["status_id"], :name => "status_id"
  add_index "posts", ["user_id"], :name => "user_id"
  add_index "posts", ["hits"], :name => "index_posts_on_hits"
  add_index "posts", ["rating"], :name => "index_posts_on_rating"

  create_table "posts_tags", :id => false, :force => true do |t|
    t.integer "post_id", :null => false
    t.integer "tag_id",  :null => false
  end

  add_index "posts_tags", ["post_id"], :name => "post_id"

  create_table "roles", :force => true do |t|
    t.string   "title",      :limit => 63,                :null => false
    t.integer  "status_id",                :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["title"], :name => "index_roles_on_title", :unique => true
  add_index "roles", ["status_id"], :name => "status_id"

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "user_id", :default => 0, :null => false
    t.integer "role_id", :default => 0, :null => false
  end

  add_index "roles_users", ["role_id"], :name => "role_id"

  create_table "statuses", :force => true do |t|
    t.string   "title",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statuses", ["title"], :name => "index_statuses_on_title", :unique => true

  create_table "tags", :force => true do |t|
    t.string   "title",       :limit => 128,                :null => false
    t.string   "keywords",    :limit => 128,                :null => false
    t.string   "description", :limit => 256,                :null => false
    t.integer  "status_id",                  :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["title"], :name => "index_tags_on_title", :unique => true
  add_index "tags", ["status_id"], :name => "status_id"

  create_table "users", :force => true do |t|
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.integer  "status_id",           :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["status_id"], :name => "status_id"

  add_foreign_key "categories", ["status_id"], "statuses", ["id"], :name => "categories_ibfk_1"

  add_foreign_key "categories_posts", ["category_id"], "categories", ["id"], :name => "categories_posts_ibfk_1"
  add_foreign_key "categories_posts", ["post_id"], "posts", ["id"], :name => "categories_posts_ibfk_2"

  add_foreign_key "comments", ["post_id"], "posts", ["id"], :name => "comments_ibfk_1"
  add_foreign_key "comments", ["status_id"], "statuses", ["id"], :name => "comments_ibfk_2"
  add_foreign_key "comments", ["user_id"], "users", ["id"], :name => "comments_ibfk_3"

  add_foreign_key "menu", ["status_id"], "statuses", ["id"], :name => "menu_ibfk_1"

  add_foreign_key "pages", ["status_id"], "statuses", ["id"], :name => "pages_ibfk_1"

  add_foreign_key "posts", ["status_id"], "statuses", ["id"], :name => "posts_ibfk_1"
  add_foreign_key "posts", ["user_id"], "users", ["id"], :name => "posts_ibfk_2"

  add_foreign_key "posts_tags", ["tag_id"], "tags", ["id"], :name => "posts_tags_ibfk_1"
  add_foreign_key "posts_tags", ["post_id"], "posts", ["id"], :name => "posts_tags_ibfk_2"

  add_foreign_key "roles", ["status_id"], "statuses", ["id"], :name => "roles_ibfk_1"

  add_foreign_key "roles_users", ["user_id"], "users", ["id"], :name => "roles_users_ibfk_1"
  add_foreign_key "roles_users", ["role_id"], "roles", ["id"], :name => "roles_users_ibfk_2"

  add_foreign_key "tags", ["status_id"], "statuses", ["id"], :name => "tags_ibfk_1"

  add_foreign_key "users", ["status_id"], "statuses", ["id"], :name => "users_ibfk_1"

end
