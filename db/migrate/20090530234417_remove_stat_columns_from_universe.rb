class RemoveStatColumnsFromUniverse < ActiveRecord::Migration
  def self.up
    remove_column :characters, :agility
    remove_column :characters, :charisma
    remove_column :characters, :cunning
    remove_column :characters, :strength
    remove_column :characters, :endurance
  end

  def self.down
    add_column :characters, :agility, :integer
    add_column :characters, :charisma, :integer
    add_column :characters, :cunning, :integer
    add_column :characters, :strength, :integer
    add_column :characters, :endurance, :integer
  end
end
