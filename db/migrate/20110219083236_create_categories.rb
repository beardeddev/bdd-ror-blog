class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :title, :limit => 64, :null => false
      t.string :keywords, :limit => 128, :null => false
      t.string :description, :limit => 256, :null => false
      t.integer :status_id, :null => false, :default => 1
      t.foreign_key :status_id, :statuses, :id

      t.timestamps
    end
    
    add_index(:categories, :title, :unique => true)
    
  end

  def self.down
    drop_table :categories
  end
end
