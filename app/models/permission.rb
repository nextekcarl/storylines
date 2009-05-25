class Permission < ActiveRecord::Base
  belongs_to :universe
  belongs_to :user

  def rights_in_words
    return "view only" if self.rights <= 1
    return "create and view" if self.rights == 2
    return "full edit" if self.rights >= 3
  end
end
