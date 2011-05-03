class CategoriesPosts < ActiveRecord::Migration
  def self.up
    create_table :categories_posts, :id => false do |t|
      t.integer :category_id, :null => false
      t.integer :post_id, :null => false
      
      t.foreign_key :category_id, :categories, :id
      t.foreign_key :post_id, :posts, :id      
    end
    
    execute('ALTER TABLE categories_posts ADD PRIMARY KEY(category_id, post_id)')
    
  end

  def self.down
    drop_table :categories_posts
  end
end
