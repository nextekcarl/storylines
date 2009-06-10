class CharactersOrganizations < ActiveRecord::Migration
  def self.up
    create_table :characters_organizations, :id => false do |t|
      t.integer :character_id, :null => false
      t.integer :organization_id, :null => false
    end
    add_index :characters_organizations, [:character_id, :organization_id], :unique => true
  end

  def self.down
    drop_table :characters_organizations
  end
end
