class MyQuality < ActiveRecord::Base
  belongs_to :character
  belongs_to :quality

  def to_label
    self.quality.name
  end
end
