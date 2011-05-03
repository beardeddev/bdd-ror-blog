class PostsTags < ActiveRecord::Migration
  def self.up
    create_table :posts_tags, :id => false do |t|
      t.integer :post_id, :null => false
      t.integer :tag_id, :null => false
      
      t.foreign_key :tag_id, :tags, :id
      t.foreign_key :post_id, :posts, :id      
    end
    
    execute('ALTER TABLE posts_tags ADD PRIMARY KEY(tag_id, post_id)')
  end

  def self.down
    drop_table :posts_tags
  end
end
