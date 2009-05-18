class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.string :name
      t.integer :age
      t.string :height
      t.string :weight
      t.integer :strength
      t.integer :cunning
      t.integer :agility
      t.integer :charisma
      t.integer :endurance
      t.text :description
      t.text :history

      t.timestamps
    end
  end

  def self.down
    drop_table :characters
  end
end
