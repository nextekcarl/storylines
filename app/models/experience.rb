class Experience < ActiveRecord::Base
  belongs_to :event
  belongs_to :character
  belongs_to :creator, :class_name => "User", :foreign_key => :created_by
  belongs_to :modifier, :class_name => "User", :foreign_key => :modified_by
  belongs_to :universe

  validates_presence_of :name

  def start_date
    if self.event.methods.include?('start_date') then
      self.event.start_date
    else
      'No date found'
    end
  end

  def authorized_for_update?
    #Greys out the associated link when the user isn't the creator or authorized
    new_record? || current_user.id == current_user.current_universe.creator_id || current_user.userlimits.find(:first, :conditions => "universe_id = #{current_user.current_universe_id}").rights >= 3
  end

  def authorized_for_destroy?
    #Greys out the associated link when the user isn't the creator or authorized
    new_record? || current_user.id == current_user.current_universe.creator_id || current_user.userlimits.find(:first, :conditions => "universe_id = #{current_user.current_universe_id}").rights >= 3
  end

  def authorized_for_create?
    #Greys out the associated link when the user isn't the creator or authorized
    current_user.id == current_user.current_universe.creator_id || current_user.userlimits.find(:first, :conditions => "universe_id = #{current_user.current_universe_id}").rights >= 2
  end

  def authorized_for_show?
    #Greys out the associated link when the user isn't the creator or authorized
    new_record? || current_user.id == current_user.current_universe.creator_id || current_user.userlimits.find(:first, :conditions => "universe_id = #{current_user.current_universe_id}").rights >= 1
  end
end
