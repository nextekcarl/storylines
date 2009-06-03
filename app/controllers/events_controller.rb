class EventsController < ApplicationController
  before_filter :login_required
  before_filter :universe_set?
  before_filter :authorized_for_viewing?, :only => [:list, :show]
  before_filter :authorized_for_creating?, :only => [:new, :create]
  before_filter :authorized_for_editing?, :only => [:edit, :update, :destroy]

  uses_tiny_mce :options => {
                :theme => 'advanced',
                :theme_advanced_toolbar_location => :top,
                :width => '400',
                :height => '300',
                :theme_advanced_statusbar_location => :bottom,
                :theme_advanced_resizing => true}

  active_scaffold :event do |config|
    config.columns = [:name, :location, :characters, :start_date, :end_date, :description, :creator, :modifier, :updated_at]
    config.create.columns.exclude [:creator, :modifier, :updated_at]
    config.subform.columns.exclude [:creator, :modifier, :updated_at]
    config.update.columns.exclude [:creator, :modifier, :updated_at]
    config.columns[:description].form_ui= :text_editor
    config.columns[:updated_at].label = "Last modified"
    config.columns[:location].label = "Occurred at"
    config.columns[:characters].label = "Cast"
    config.columns[:description].label = "Objective Description"
    config.create.columns.exclude [:characters]
    config.show.link.inline = false
    config.subform.layout = :vertical
    config.list.sorting = { :start_date => :asc }
    config.nested.add_link(:experiences, [:experiences], :inline => false)
  end

  def conditions_for_collection
    ['events.universe_id = ?', ["#{current_user.current_universe_id}"]]
  end

    protected

  def before_create_save(record)
    record.created_by = session[:user_id]
    record.modified_by = session[:user_id]
    record.universe_id = current_user.current_universe_id
  end

  def before_update_save(record)
    record.modified_by = session[:user_id]
  end
end
