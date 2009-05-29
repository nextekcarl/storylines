class AddCurrentUniverseToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :current_universe_id, :integer
  end

  def self.down
    remove_column :users, :current_universe_id
  end
end
