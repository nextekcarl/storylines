class CreateMyQualities < ActiveRecord::Migration
  def self.up
    create_table :my_qualities do |t|
      t.integer :level
      t.integer :quality_id
      t.integer :character_id

      t.timestamps
    end
  end

  def self.down
    drop_table :my_qualities
  end
end
