class Event < ActiveRecord::Base
  belongs_to :location
  has_and_belongs_to_many :characters
  has_many :experiences

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

end
