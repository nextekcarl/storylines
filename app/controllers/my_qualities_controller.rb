class MyQualitiesController < ApplicationController
  before_filter :login_required
  before_filter :universe_set?
  before_filter :authorized_for_viewing?, :only => [:list, :show]
  before_filter :authorized_for_creating?, :only => [:new, :create]
  before_filter :authorized_for_editing?, :only => [:edit, :update, :destroy]

  active_scaffold :my_qualities do |config|
    config.label = "My Qualities"
    config.columns = [:quality, :character, :level]
    config.subform.layout = :vertical
  end

  def list
    flash[:error] = "Unauthorized access."
    redirect_to :controller => :universes
  end

  def index
    flash[:error] = "Unauthorized access."
    redirect_to :controller => :universes
  end
end
