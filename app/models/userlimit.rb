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
    #Greys out the associated link when the user isn't the creator or authorized
    new_record? || current_user.id == self.universe.creator_id
  end

  def authorized_for_destroy?
    #Greys out the associated link when the user isn't the creator or authorized
    new_record? || current_user.id == self.universe.creator_id
  end

  def authorized_for_create?
    #Greys out the associated link when the user isn't the creator or authorized
    #Or at least it is supposed to do that, doesn't work so had to hardwire it.
    puts "\n\n\n|#{self.universe_id}|\n\n\n"
    true || current_user.id == self.universe.creator_id
  end

  def authorized_for_show?
    #Greys out the associated link when the user isn't the creator or authorized
    new_record? || current_user.id == self.universe.creator_id
  end
end
