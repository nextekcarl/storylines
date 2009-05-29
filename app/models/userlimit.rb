class Userlimit < ActiveRecord::Base
  belongs_to :universe
  belongs_to :user

  def rights_in_words
    return "view only" if self.rights <= 1
    return "create and view" if self.rights == 2
    return "full edit" if self.rights >= 3
  end

  def to_label
    "permissions for user:#{self.user.username}"
  end

  def authorized_for_update?
    #Greys out the associated link when the user isn't the creator
    new_record? || current_user.id == current_user.current_universe.creator_id
  end

  def authorized_for_destroy?
    #Greys out the associated link when the user isn't the creator
    new_record? || current_user.id == current_user.current_universe.creator_id
  end

  def authorized_for_create?
    #Greys out the associated link when the user isn't the creator
    current_user.id == current_user.current_universe.creator_id
  end

  def authorized_for_show?
    #Greys out the associated link when the user isn't the creator
    new_record? || current_user.id == current_user.current_universe.creator_id
  end
end
