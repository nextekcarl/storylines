class CreateMyStats < ActiveRecord::Migration
  def self.up
    create_table :my_stats do |t|
      t.integer :level
      t.integer :stat_id
      t.integer :character_id

      t.timestamps
    end
  end

  def self.down
    drop_table :my_stats
  end
end
