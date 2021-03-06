class Universe < ActiveRecord::Base
  has_many :userlimits, :dependent => :destroy
  has_many :users, :through => :userlimits
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
  has_many :required_stats, :dependent => :destroy
  has_many :stats, :through => :required_stats
  has_many :events, :dependent => :destroy
  has_many :locations, :dependent => :destroy
  has_many :experiences, :dependent => :destroy
  has_many :characters, :dependent => :destroy
  has_many :current_visitors, :class_name => "User", :foreign_key => :current_universe_id, :dependent => :nullify
  has_many :organizations, :dependent => :destroy

  validates_uniqueness_of :name, :case_sensitive => false
#  def authorized_for_update?
#    logger.error "current user id = #{current_user.id}, self stats = #{self.to_yaml}"
#    return false unless current_user.id == self.creator_id
#  end

  def authorized_for_update?
    #Greys out the edit link when the user isn't the creator
    new_record? || current_user.id == self.creator_id
  end

  def authorized_for_destroy?
    #Greys out the edit link when the user isn't the creator
    new_record? || current_user.id == self.creator_id
  end
end
