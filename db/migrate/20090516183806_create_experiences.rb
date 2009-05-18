class CreateExperiences < ActiveRecord::Migration
  def self.up
    create_table :experiences do |t|
      t.string :name
      t.integer :character_id
      t.integer :event_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :experiences
  end
end
