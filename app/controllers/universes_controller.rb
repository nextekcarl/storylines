class UniversesController < ApplicationController
  before_filter :login_required
  before_filter :authorized?, :only => [:edit, :update, :destroy]
  before_filter :show_redirect, :only => [:show]
  after_filter :unset_universe_session_id, :only => [:index, :list]
  before_filter :add_permitted_universes, :only => [:index, :list, :update_table]

  uses_tiny_mce :options => {
                :theme => 'advanced',
                :theme_advanced_toolbar_location => :top,
                :theme_advanced_toolbar_align => :left,
                :width => '500',
                :height => '400'}

  active_scaffold :universe do |config|
    config.columns = [:creator, :name, :description]
    config.columns[:description].form_ui= :text_editor
    config.create.columns.exclude [:creator]
    config.update.columns.exclude [:creator]
    config.show.link.inline = false
    config.show.link.label = "Select"
  end

  def conditions_for_collection
    if @permitted_universes.empty?
      ['universes.creator_id = ?', ["#{current_user.id}"]]
    else
      logger.error("#{current_user.id}, #{@permitted_universes.join(',')}")
      ["universes.creator_id = ? or universes.id IN (#{@permitted_universes.join(',')})", ["#{current_user.id}"]]
    end
  end

  protected

  def before_create_save(record)
    record.creator_id = current_user.id
  end

  def authorized?
    #Only works correctly if not using ajax.
    @universe = Universe.find(params[:id])
    unless @universe.creator_id == current_user.id
      unset_universe_session_id
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
      current_user.current_universe = @universe
      current_user.save
      redirect_to :controller => :characters
    else
      unset_universe_session_id
      flash[:error] = "You are not authorized to view that Universe's contents."
      redirect_to :controller => :universes
    end
  end

  def add_permitted_universes
    @permitted_universes = Array.new
    unless current_user.userlimits.empty?
      current_user.userlimits.each do |userlimit|
        @permitted_universes << userlimit.universe.id
      end
    end
    @permitted_universes
  end
end
