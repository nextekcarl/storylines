class MyQualitiesController < ApplicationController
  before_filter :login_required
  before_filter :universe_set?
  before_filter :authorized_for_viewing?, :only => [:list, :show]
  before_filter :authorized_for_creating?, :only => [:new, :create]
  before_filter :authorized_for_editing?, :only => [:edit, :update, :destroy]

  active_scaffold :my_qualities do |config|
    config.columns = [:quality, :character, :level]
    config.show.link.inline = false
    config.update.link.inline = false
    config.create.link.inline = false
    config.delete.link.inline = false
  end

  def list
    flash[:error] = "Unauthorized access."
    redirect_to root_url
  end

  def index
    flash[:error] = "Unauthorized access."
    redirect_to root_url
  end
end
