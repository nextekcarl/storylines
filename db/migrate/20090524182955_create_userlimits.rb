class CreateUserlimits < ActiveRecord::Migration
  def self.up
    create_table :userlimits do |t|
      t.integer :universe_id
      t.integer :user_id
      t.integer :rights

      t.timestamps
    end
  end

  def self.down
    drop_table :userlimits
  end
end
