class Quality < ActiveRecord::Base
  has_many :my_quality
  has_many :characters, :through => :my_quality
end
