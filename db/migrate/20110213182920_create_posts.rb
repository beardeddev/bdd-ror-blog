class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title, :null => false, :limit => 128
      t.string :title_transliterated, :null => false, :limit => 256
      t.string :keywords, :null => false, :limit => 128
      t.string :description, :null => false, :limit => 1024
      t.text :body, :null => false
      t.integer :status_id, :null => false, :default => 1
      t.integer :hits, :null => false, :default => 0
      t.integer :rating, :null => false, :default => 0
      t.integer :user_id, :null => false, :default => 1

      t.timestamps
      
      t.foreign_key :status_id, :statuses, :id
      t.foreign_key :user_id, :users, :id
    end
    
    add_index(:posts, :hits)
    add_index(:posts, :rating)
    
  end

  def self.down
    drop_table :posts
  end
end
