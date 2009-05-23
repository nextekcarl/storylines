class CharactersController < ApplicationController
  before_filter :login_required

  active_scaffold :character do |config|
    #config.label = "Characters"
    config.columns =[:name, :age, :height, :weight, :strength, :cunning, :agility, :charisma,
      :endurance, :description, :history, :experiences, :events, :creator, :modifier, :updated_at]
    config.create.columns.exclude [:creator, :modifier, :updated_at]
    config.subform.columns.exclude [:creator, :modifier, :updated_at]
    config.update.columns.exclude [:creator, :modifier, :updated_at]
    config.columns[:updated_at].label = "Last modified"
    config.show.link.inline = false
    config.subform.layout = :vertical
    #config.subform.layout = :vertical
    #config.nested.add_link(“Events”, [:events])
    #list.columns.exclude :comments
    #list.sorting = {:name => 'ASC'}
    #columns[:phone].label = "Phone #"
    #columns[:phone].description = "(Format: ###-###-####)"
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
