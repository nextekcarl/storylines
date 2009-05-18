class Character < ActiveRecord::Base
  has_and_belongs_to_many :events
  has_many :experiences

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  validates_inclusion_of :strength, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :agility, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :cunning, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :charisma, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :endurance, :in => 0..10, :message => 'must be between 0 and 10'

end