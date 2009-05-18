class CharactersEvents < ActiveRecord::Migration
  def self.up
    create_table :characters_events, :id => false do |t|
      t.integer :character_id, :null => false
      t.integer :event_id, :null => false
    end
    add_index :characters_events, [:character_id, :event_id], :unique => true
  end

  def self.down
  end
end
