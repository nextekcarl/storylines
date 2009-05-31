class MyStat < ActiveRecord::Base
  belongs_to :character
  belongs_to :stat

  def to_label
    self.stat.name
  end
end
