class CreateRequiredStats < ActiveRecord::Migration
  def self.up
    create_table :required_stats do |t|
      t.integer :universe_id
      t.integer :stat_id

      t.timestamps
    end
  end

  def self.down
    drop_table :required_stats
  end
end
