class Quality < ActiveRecord::Base
  has_many :my_quality, :dependent => :destroy
  has_many :characters, :through => :my_quality

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
end
