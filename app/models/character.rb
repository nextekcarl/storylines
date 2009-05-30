class Character < ActiveRecord::Base
  has_and_belongs_to_many :events
  has_many :experiences
  belongs_to :creator, :class_name => "User", :foreign_key => :created_by
  belongs_to :modifier, :class_name => "User", :foreign_key => :modified_by
  belongs_to :universe

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false, :scope => :universe_id

  validates_inclusion_of :strength, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :agility, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :cunning, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :charisma, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :endurance, :in => 0..10, :message => 'must be between 0 and 10'

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
