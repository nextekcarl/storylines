class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.integer :universe_id
      t.integer :user_id
      t.integer :rights

      t.timestamps
    end
  end

  def self.down
    drop_table :permissions
  end
end
