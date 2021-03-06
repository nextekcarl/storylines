class MyQuality < ActiveRecord::Base
  belongs_to :character
  belongs_to :quality

  validates_presence_of :quality_id, :message => "must have name."
  validates_inclusion_of :level, :in => 0..10, :message => 'must be between 0 and 10'

  def to_label
    self.quality.name
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
