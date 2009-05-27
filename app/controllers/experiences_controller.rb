class ExperiencesController < ApplicationController
  before_filter :login_required
  before_filter :universe_set?
  before_filter :authorized_for_viewing?, :only => [:list, :show]
  before_filter :authorized_for_creating?, :only => [:new, :create]
  before_filter :authorized_for_editing?, :only => [:edit, :update, :destroy]

  active_scaffold :experience do |config|
    config.label = "Personal experience"
    config.columns = [:name, :character, :event, :description, :start_date, :creator, :modifier, :updated_at]
    config.create.columns.exclude [:creator, :modifier, :updated_at]
    config.subform.columns.exclude [:creator, :modifier, :updated_at, :start_date]
    config.update.columns.exclude [:creator, :modifier, :updated_at]
    config.columns[:updated_at].label = "Last modified"
    config.update.columns.exclude :start_date
    config.create.columns.exclude :start_date
    config.subform.layout = :vertical
    config.columns[:start_date].includes = [:event]
    config.list.sorting = { :start_date => :asc }
  end

  def conditions_for_collection
    ['experiences.universe_id = ?', ["#{session[:universe_id]}"]]
  end

    protected

  def before_create_save(record)
    record.created_by = session[:user_id]
    record.modified_by = session[:user_id]
    record.universe_id = session[:universe_id]
  end

  def before_update_save(record)
    record.modified_by = session[:user_id]
  end
end
