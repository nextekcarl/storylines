class UserlimitsController < ApplicationController
  before_filter :login_required
  before_filter :universe_set?
  before_filter :authorized_for_viewing?, :only => [:list]
  before_filter :authorized?, :only => [:new, :show, :create, :edit, :update, :destroy]

  active_scaffold :userlimits do |config|
    config.columns = [:user, :rights]
    config.delete.link.label = "Revoke access"
    config.actions.exclude :update #Excluded since it doesn't work
    config.show.link.inline = false
    #config.update.link.inline = false #Should re-enable if ever figured out
    config.create.link.inline = false
    config.delete.link.inline = false
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
    #Only works correctly if not using ajax.
    @universe = Universe.find(current_user.current_universe_id)
    unless @universe.creator_id == current_user.id
      flash[:error] = "Only the creator of a Universe may modify permissions."
      redirect_to '/'
      return false
    end
  end

end
