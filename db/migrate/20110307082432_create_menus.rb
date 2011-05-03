class CreateMenus < ActiveRecord::Migration
  def self.up
    create_table :menu do |t|
      t.string :key, :limit => 32, :null => false
      t.string :name, :limit => 128, :null => false
      t.string :url, :limit => 128, :null => false
      t.integer :status_id, :null => false

      t.foreign_key :status_id, :statuses, :id

      t.timestamps
    end

    add_index(:menu, :key, :unique => true)
    add_index(:menu, :name, :unique => true)
    add_index(:menu, :url, :unique => true)

  end

  def self.down
    drop_table :menu
  end
end
