class Event < ActiveRecord::Base
  belongs_to :location
  has_and_belongs_to_many :characters
  has_many :experiences, :dependent => :nullify
  belongs_to :creator, :class_name => "User", :foreign_key => :created_by
  belongs_to :modifier, :class_name => "User", :foreign_key => :modified_by
  belongs_to :universe

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false, :scope => :universe_id


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
