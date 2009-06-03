class Stat < ActiveRecord::Base
  has_many :my_stats, :dependent => :destroy
  has_many :characters, :through => :my_characters, :class_name => 'my_stat', :foreign_key => :character_id
  has_many :required_stats, :dependent => :destroy
  has_many :universes, :through => :required_stats

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
end
