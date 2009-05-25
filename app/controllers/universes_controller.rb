class UniversesController < ApplicationController
  before_filter :login_required
  before_filter :authorized?, :only => [:update, :destroy]

  active_scaffold :universe do |config|
    config.columns = [:creator, :name, :description]
  end

  protected

  def before_create_save(record)
    record.creator_id = session[:user_id]
  end

# Doesn't work, see authorized? method below for work around.
#  def before_update_save(record)
#    unless record.creator_id == session[:user_id]
#      flash[:notice] = "Only the creator of a Universe may modify it."
#      redirect_to :controller => :universe
#      return false
#    end
#  end

  def authorized?
    #This results in an ugly 500 internal server error and the flash doesn't get
    #rendered, but it does protect the data properly. Working on a fix.
    @universe = Universe.find(params[:id])
    unless @universe.creator_id == session[:user_id]
      flash[:notice] = "Only the creator of a Universe may modify it."
      redirect_to :controller => :universe
      return false
    end
  end
end
