class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title, :null => false, :limit => 64
      t.string :keywords, :null => false, :limit => 128
      t.string :description, :null => false, :limit => 256
      t.string :url, :null => false, :limit => 32 
      t.text :body
      t.integer :status_id, :null => false, :default => 1
      t.foreign_key :status_id, :statuses, :id

      t.timestamps
    end
    
    add_index(:pages, :url, :unique => true)
            
  end

  def self.down
    drop_table :pages
  end
end
