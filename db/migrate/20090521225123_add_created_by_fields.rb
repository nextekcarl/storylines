class AddCreatedByFields < ActiveRecord::Migration
  def self.up
    add_column :characters, :created_by, :integer, :default => 1
    add_column :events, :created_by, :integer, :default => 1
    add_column :locations, :created_by, :integer, :default => 1
    add_column :experiences, :created_by, :integer, :default => 1
    add_column :characters, :modified_by, :integer, :default => 1
    add_column :events, :modified_by, :integer, :default => 1
    add_column :locations, :modified_by, :integer, :default => 1
    add_column :experiences, :modified_by, :integer, :default => 1
  end

  def self.down
    remove_column :characters, :created_by
    remove_column :events, :created_by
    remove_column :locations, :created_by
    remove_column :experiences, :created_by
    remove_column :characters, :modified_by
    remove_column :events, :modified_by
    remove_column :locations, :modified_by
    remove_column :experiences, :modified_by
  end
end
