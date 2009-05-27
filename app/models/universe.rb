class Universe < ActiveRecord::Base
  has_many :userlimits
  has_many :users, :through => :userlimits
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id

#  def authorized_for_update?
#    logger.error "current user id = #{current_user.id}, self stats = #{self.to_yaml}"
#    return false unless current_user.id == self.creator_id
#  end
end
