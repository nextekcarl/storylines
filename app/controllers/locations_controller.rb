class LocationsController < ApplicationController
  before_filter :login_required

  active_scaffold :location do |config|
    config.columns = [:name, :description, :events, :creator, :modifier, :updated_at]
    config.columns[:updated_at].label = "Last modified"
    config.show.link.inline = false
    config.subform.layout = :vertical
  end

    protected

  def before_update_save(record)
    if record.new_record? then
      record.created_by = session[:user_id]
      record.modified_by = session[:user_id]
    else
      record.modified_by = session[:user_id]
    end
  end

  def before_update_save(record)
    record.modified_by = session[:user_id]
  end
end
