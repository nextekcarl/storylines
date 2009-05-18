class Experience < ActiveRecord::Base
  belongs_to :event
  belongs_to :character

  validates_presence_of :name

  def start_date
    if self.event.methods.include?('start_date') then
      self.event.start_date
    else
      'No date found'
    end
  end
end
