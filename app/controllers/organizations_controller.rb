class OrganizationsController < ApplicationController
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

   active_scaffold :organization do |config|
    config.columns =[:name, :parent, :mission_statement, :agenda, :my_stats,
                     :manpower, :specialists, :transportation, :internal_security,
                     :knowledge, :publicity, :public_relations, :intrusion,
                     :slush_funds, :bases, :bureaucracy, :firepower, :creator,
                     :modifier, :updated_at, :characters]
    config.columns[:updated_at].label = "Last modified"
    config.columns[:characters].label = "Members"
    config.columns[:parent].form_ui= :select
    config.columns[:agenda].form_ui= :text_editor
    config.columns[:mission_statement].form_ui= :text_editor
    config.show.columns.exclude [:manpower,
                     :specialists, :transportation, :internal_security,
                     :knowledge, :publicity, :public_relations, :intrusion,
                     :slush_funds, :bases, :bureaucracy, :firepower]
    config.create.columns.exclude [:creator, :modifier, :updated_at, :my_stats, :members]
    config.update.columns.exclude [:creator, :modifier, :updated_at, :my_stats, :members]
    config.list.columns.exclude [:mission_statement, :agenda, :manpower,
                     :specialists, :transportation, :internal_security,
                     :knowledge, :publicity, :public_relations, :intrusion,
                     :slush_funds, :bases, :bureaucracy, :firepower]
    config.columns[:my_stats].label = "Stats"
    config.subform.layout = :vertical
   end

   def conditions_for_collection
    ['organizations.universe_id = ?', ["#{current_user.current_universe_id}"]]
  end

  protected

  def before_create_save(record)
    record.created_by = current_user.id
    record.modified_by = current_user.id
    record.universe_id = current_user.current_universe_id
  end

  def before_update_save(record)
    record.modified_by = current_user.id
  end
end
