class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.string :title, :null => false, :unique => true
      t.timestamps
    end
    
    add_index(:statuses, :title, :unique => true)
    
  end

  def self.down
    drop_table :statuses
  end
end
