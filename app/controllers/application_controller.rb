# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation

  ActiveScaffold.set_defaults do |config|
    config.ignore_columns.add [:created_at, :lock_version]
    config.show.link.inline = false
  end

  protected

  def universe_set?
    if session[:universe_id].blank?
      flash[:notice] = "You must select a Universe first."
      redirect_to '/'
    end
  end

  def authorized_for_viewing?
    if authorized(1)
      return true
    else
      flash[:error] = "You are not authorized to view that Universe's contents."
      redirect_to :controller => :universes
    end
  end

  def authorized_for_creating?
    if authorized(2)
      return true
    else
      flash[:error] = "You are not authorized to create anything in that Universe."
      redirect_to :controller => :universes
    end
  end

  def authorized_for_editing?
    if authorized(3)
      return true
    else
      flash[:error] = "You are not authorized to edit that Universe's contents."
      redirect_to :controller => :universes
    end
  end

  def authorized(rights_requested)
    #This will redirect the user to start seeing the elements in this particular
    #Universe, assuming they either created it or have been permitted to see it
    #by the creator of that Universe.
    @universe = Universe.find(session[:universe_id])
    @permission = @universe.permissions.find(:first, :conditions => ["user_id = ? and rights >= ?", current_user.id, rights_requested])
    if @universe.creator_id == current_user.id or !@permission.nil?
      return true
    else
      return false
    end
  end

#Very basic check, has been replaced in code, just being kept around as an example
#  def permissions_check
#    @okay = false
#    @user = User.find(session[:user_id])
#    @universe = Universe.find(session[:universe_id])
#    (@okay = true) if @user.own_universes.include?(@universe)
#    (@okay = true) if @user.universes.include?(@universe)
#    unless @okay
#      flash[:notice] = "You don't have permission to view that Universe"
#      logger.error "User ID:#{@user.id} #{@user.username} doesn't have permission to view Universe id #{session[:universe_id]}"
#      redirect_to '/'
#      return
#    end
#  end
end
