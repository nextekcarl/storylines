class UserlimitsController < ApplicationController
  before_filter :login_required
  before_filter :universe_set?
  before_filter :authorized_for_viewing?, :only => [:list]
  before_filter :authorized?, :only => [:new, :show, :create, :edit, :update, :destroy]

  active_scaffold :userlimits do |config|
    config.columns = [:user, :rights]
    config.delete.link.label = "Revoke access"
    config.actions.exclude :update #Excluded since it doesn't work
  end

  def conditions_for_collection
    ['userlimits.universe_id = ?', ["#{current_user.current_universe_id}"]]
  end

  protected
  def before_create_save(record)
    record.universe_id = current_user.current_universe_id
    record.user_id = params[:record][:user_id]
  end

  def authorized?
    @universe = Universe.find(current_user.current_universe_id)
    unless @universe.creator_id == current_user.id
      flash[:error] = "Only the creator of a Universe may modify permissions."
      redirect_to :controller => :universes
      return false
    end
  end

end
