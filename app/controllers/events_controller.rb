class EventsController < ApplicationController
  before_filter :login_required

  active_scaffold :event do |config|
    config.columns = [:name, :location, :characters, :start_date, :end_date, :description, :creator, :modifier, :updated_at]
    config.create.columns.exclude [:creator, :modifier, :updated_at]
    config.subform.columns.exclude [:creator, :modifier, :updated_at]
    config.update.columns.exclude [:creator, :modifier, :updated_at]
    config.columns[:updated_at].label = "Last modified"
    config.columns[:location].label = "Occurred at"
    config.columns[:characters].label = "Cast"
    config.columns[:description].label = "Objective Description"
    #config.show.link.inline = false
    config.subform.layout = :vertical
    config.list.sorting = { :start_date => :asc }
    config.nested.add_link(:Cast, [:characters], :inline => false)
    config.nested.add_link(:experiences, [:experiences], :inline => false)
  end

    protected

  def before_create_save(record)
    record.created_by = session[:user_id]
    record.modified_by = session[:user_id]
  end

  def before_update_save(record)
    record.modified_by = session[:user_id]
  end
end
