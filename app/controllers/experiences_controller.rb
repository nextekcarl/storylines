class ExperiencesController < ApplicationController
  before_filter :login_required

  active_scaffold :experience do |config|
    config.label = "Personal experience"
    config.columns = [:name, :character, :event, :description, :start_date]
    config.update.columns.exclude :start_date
    config.create.columns.exclude :start_date
    config.subform.layout = :vertical
    config.columns[:start_date].includes = [:event]
    config.list.sorting = { :start_date => :asc }
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
