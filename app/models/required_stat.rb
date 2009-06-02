class RequiredStat < ActiveRecord::Base
  belongs_to :universe
  belongs_to :stat

  def to_label
    return '' if self.stat.nil?
    self.stat.name
  end
end
