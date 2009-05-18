class EventsController < ApplicationController
  active_scaffold :event do |config|
    config.columns = [:name, :location, :characters, :start_date, :end_date, :description]
    config.columns[:location].label = "Occurred at"
    config.columns[:characters].label = "Cast"
    config.columns[:description].label = "Objective Description"
    #config.show.link.inline = false
    config.subform.layout = :vertical
    config.list.sorting = { :start_date => :asc }
    config.nested.add_link(:Cast, [:characters], :inline => false)
    config.nested.add_link(:experiences, [:experiences], :inline => false)
  end
end
