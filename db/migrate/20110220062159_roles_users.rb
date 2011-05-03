class RolesUsers < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false do |t|
      t.integer :user_id
      t.integer :role_id

      t.foreign_key :user_id, :users, :id
      t.foreign_key :role_id, :roles, :id
    end

    execute('ALTER TABLE roles_users ADD PRIMARY KEY(user_id, role_id)')

  end

  def self.down
    drop_table :roles_users
  end
end
