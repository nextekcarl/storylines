class RequiredStat < ActiveRecord::Base
  belongs_to :universe
  belongs_to :stat

  def to_label
    self.stat.name
  end
end
