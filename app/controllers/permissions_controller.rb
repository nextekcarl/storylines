class PermissionsController < ApplicationController
  before_filter :login_required
  before_filter :universe_set?
  before_filter :authorized_for_viewing?, :only => [:list]
  before_filter :authorized?, :only => [:new, :show, :create, :edit, :update, :destroy]

#  active_scaffold :permission do |config|
#    config.columns = [:user, :rights]
#  end

  def conditions_for_collection
    ['permissions.universe_id = ?', ["#{session[:universe_id]}"]]
  end

  protected
  def before_create_save(record)
    record.universe_id = session[:universe_id]
    record.user_id = params[:record][:user_id]
  end

  def authorized?
    #Only works correctly if not using ajax.
    @universe = Universe.find(session[:universe_id])
    unless @universe.creator_id == current_user.id
      flash[:error] = "Only the creator of a Universe may modify permissions."
      redirect_to '/'
      return false
    end
  end

end
