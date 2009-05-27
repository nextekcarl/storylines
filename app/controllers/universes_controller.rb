class UniversesController < ApplicationController
  before_filter :login_required
  before_filter :authorized?, :only => [:edit, :update, :destroy]
  before_filter :show_redirect, :only => [:show]
  after_filter :unset_universe_session_id, :only => [:index]
  before_filter :add_permitted_universes, :only => [:index]

  active_scaffold :universe do |config|
    config.columns = [:creator, :name, :description]
    config.create.columns.exclude [:creator]
    config.update.columns.exclude [:creator]
    config.show.link.inline = false
    config.show.link.label = "Select"
    config.update.link.inline = false
    config.create.link.inline = false
    config.delete.link.inline = false
  end

  def conditions_for_collection
    if @permitted_universes.empty?
      ['universes.creator_id = ?', ["#{current_user.id}"]]
    else
      ['universes.creator_id = ? or universes.id IN (?)', ["#{current_user.id}", "#{@permitted_universes.join(',')}"]]
    end
  end

  protected

  def before_create_save(record)
    record.creator_id = current_user.id
  end

# Doesn't work, see authorized? method below for work around.
#  def before_update_save(record)
#    unless record.creator_id == session[:user_id]
#      flash[:notice] = "Only the creator of a Universe may modify it."
#      redirect_to :controller => :universe#{@permitted_universes.join(',')}
#      return false
#    end
#  end

  def authorized?
    #Only works correctly if not using ajax.
    @universe = Universe.find(params[:id])
    unless @universe.creator_id == current_user.id
      flash[:error] = "Only the creator of a Universe may modify it."
      redirect_to :controller => :universes
      return false
    end
  end

  def show_redirect
    #This will redirect the user to start seeing the characters in this particular
    #Universe, assuming they either created it or have been permitted to see it
    #by the creator of that Universe.
    @universe = Universe.find(params[:id])
    @permission = @universe.userlimits.find(:first, :conditions => ["user_id = ? and rights >= 1", current_user.id])
    if @universe.creator_id == current_user.id or !@permission.nil?
      session[:universe_id] = @universe.id
      redirect_to :controller => :characters
    else
      flash[:error] = "You are not authorized to view that Universe's contents."
      redirect_to :controller => :universes
    end
  end

  def unset_universe_session_id
    session[:universe_id] = nil
  end

  def add_permitted_universes
    @permitted_universes = Array.new
    unless current_user.userlimits.empty?
      current_user.userlimits.each do |userlimit|
        @permitted_universes << userlimit.universe.id
      end
      @permitted_universes
    end
  end
end
