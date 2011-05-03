class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :title, :null => false, :limit => 128
      t.string :keywords, :limit => 128, :null => false
      t.string :description, :limit => 256, :null => false
      t.integer :status_id, :null => false, :default => 1
      t.foreign_key :status_id, :statuses, :id
      t.timestamps
    end
    
    add_index(:tags, :title, :unique => true)
    
  end

  def self.down
    drop_table :tags
  end
end
