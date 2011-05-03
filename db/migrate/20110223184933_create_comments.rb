class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :user_name, :null => false, :limit => 24
      t.string :email, :null => false, :limit => 64
      t.string :website, :limit => 128
      t.text :body, :null => false

      t.integer :post_id, :null => false
      t.foreign_key :post_id, :posts, :id

      t.integer :status_id, :null => false, :default => 1
      t.foreign_key :status_id, :statuses, :id

      t.integer :user_id
      t.foreign_key :user_id, :users, :id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
