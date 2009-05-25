class Event < ActiveRecord::Base
  belongs_to :location
  has_and_belongs_to_many :characters
  has_many :experiences
  belongs_to :creator, :class_name => "User", :foreign_key => :created_by
  belongs_to :modifier, :class_name => "User", :foreign_key => :modified_by
  belongs_to :universe

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

end
