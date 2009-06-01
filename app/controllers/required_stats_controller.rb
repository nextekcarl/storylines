class RequiredStatsController < ApplicationController
  before_filter :login_required
  before_filter :universe_set?
  before_filter :authorized_for_viewing?, :only => [:list, :show]
  before_filter :authorized_for_creating?, :only => [:new, :create]
  before_filter :authorized_for_editing?, :only => [:edit, :update, :destroy]

  active_scaffold :required_stat do |config|
    config.columns = [:stat, :universe]
    config.show.link.inline = false
    config.update.link.inline = false
    config.create.link.inline = false
    config.delete.link.inline = false
  end

  def conditions_for_collection
    ['required_stats.universe_id = ?', ["#{current_user.current_universe_id}"]]
  end
end
