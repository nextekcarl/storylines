class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.integer :location_id
      t.datetime :start_date
      t.datetime :end_date
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
