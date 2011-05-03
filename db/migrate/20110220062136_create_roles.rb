class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :title, :limit => 63, :null => false
      t.integer :status_id, :null => false, :default => 1
      t.foreign_key :status_id, :statuses, :id

      t.timestamps
    end

    add_index(:roles, :title, :unique => true)

  end

  def self.down
    drop_table :roles
  end
end
