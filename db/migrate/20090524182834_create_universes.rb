class CreateUniverses < ActiveRecord::Migration
  def self.up
    create_table :universes do |t|
      t.integer :creator_id
      t.string :name
      t.text :description

      t.timestamps
    end
    add_column :characters, :universe_id, :integer, :default => 1
    add_column :events, :universe_id, :integer, :default => 1
    add_column :locations, :universe_id, :integer, :default => 1
    add_column :experiences, :universe_id, :integer, :default => 1
  end

  def self.down
    drop_table :universes
    remove_column :characters, :universe_id
    remove_column :events, :universe_id
    remove_column :locations, :universe_id
    remove_column :experiences, :universe_id
  end
end
