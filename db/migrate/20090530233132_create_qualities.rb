class CreateQualities < ActiveRecord::Migration
  def self.up
    create_table :qualities do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :qualities
  end
end
