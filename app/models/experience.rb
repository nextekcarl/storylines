class Experience < ActiveRecord::Base
  belongs_to :event
  belongs_to :character
  belongs_to :creator, :class_name => "User", :foreign_key => :created_by
  belongs_to :modifier, :class_name => "User", :foreign_key => :modified_by
  belongs_to :universe

  validates_presence_of :name

  def start_date
    if self.event.methods.include?('start_date') then
      self.event.start_date
    else
      'No date found'
    end
  end
end
