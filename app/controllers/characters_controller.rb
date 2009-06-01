class CharactersController < ApplicationController
  before_filter :login_required
  before_filter :universe_set?
  before_filter :authorized_for_viewing?, :only => [:list, :show]
  before_filter :authorized_for_creating?, :only => [:new, :create]
  before_filter :authorized_for_editing?, :only => [:edit, :update, :destroy]

  active_scaffold :character do |config|
    #config.label = "Characters"
    config.columns =[:name, :age, :height, :weight, :my_stats, :my_qualities, :description, :history,
    :experiences, :events, :creator, :modifier, :updated_at]
    config.create.columns.exclude [:creator, :modifier, :updated_at]
    config.list.columns.exclude [:description, :history]
    config.subform.columns.exclude [:creator, :modifier, :updated_at]
    config.update.columns.exclude [:creator, :modifier, :updated_at]
    config.columns[:updated_at].label = "Last modified"
    config.show.link.inline = false
    config.update.link.inline = false
    config.create.link.inline = false
    config.delete.link.inline = false
    config.subform.layout = :vertical
    #config.subform.layout = :vertical
    #config.nested.add_link(“Events”, [:events])
    #list.columns.exclude :comments
    #list.sorting = {:name => 'ASC'}
    #columns[:phone].label = "Phone #"
    #columns[:phone].description = "(Format: ###-###-####)"
  end

  def conditions_for_collection
    ['characters.universe_id = ?', ["#{current_user.current_universe_id}"]]
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

  def after_create_save(record)
    required_stats = Array.new
    unset_stats = Array.new
    set_stats = Array.new
    for temp in current_user.current_universe.required_stats
      required_stats << temp.stat_id
    end
    for temp in record.my_stats
      set_stats << temp.stat_id
    end
    unset_stats = required_stats - set_stats
    for temp in unset_stats
      stat = MyStat.new(:stat_id => temp, :character_id => record.id, :level => 0)
      stat.save
    end
  end
  def after_update_save(record)
    required_stats = Array.new
    unset_stats = Array.new
    set_stats = Array.new
    for temp in current_user.current_universe.required_stats
      required_stats << temp.stat_id
    end
    for temp in record.my_stats
      set_stats << temp.stat_id
    end
    unset_stats = required_stats - set_stats
    for temp in unset_stats
      stat = MyStat.new(:stat_id => temp, :character_id => record.id, :level => 0)
      stat.save
    end
  end
end
