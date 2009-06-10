class CreateOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string :name
      t.integer :parent_id
      t.text :mission_statement
      t.text :agenda
      t.integer :manpower
      t.integer :specialists
      t.integer :transportation
      t.integer :internal_security
      t.integer :firepower
      t.integer :knowledge
      t.integer :publicity
      t.integer :public_relations
      t.integer :intrusion
      t.integer :slush_funds
      t.integer :bases
      t.integer :bureaucracy
      t.integer :universe_id
      t.integer :created_by
      t.integer :modified_by

      t.timestamps
    end
  end

  def self.down
    drop_table :organizations
  end
end
