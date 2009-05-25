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
  end

  protected

  def permissions_check
    @okay = false
    @user = User.find(session[:user_id])
    @universe = Universe.find(session[:universe_id])
    (@okay = true) if @user.own_universes.include?(@universe)
    (@okay = true) if @user.universes.include?(@universe)
    unless @okay
      flash[:notice] = "You don't have permission to view that Universe"
      logger.error "User doesn't have permission to view Universe id #{session[:universe_id]}"
      redirect_to '/'
      return
    end
  end
end
