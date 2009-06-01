class StatsController < ApplicationController
  before_filter :login_required


  active_scaffold :stat do |config|
    config.columns = [:name]
    config.show.link.inline = false
    config.update.link.inline = false
    config.create.link.inline = false
    config.delete.link.inline = false
  end

  def update
    flash[:notice] = "Only the admin can edit stat names. This is to prevent stats across Universes from changing."
    redirect_to root_url
  end

  def edit
    flash[:notice] = "Only the admin can edit stat names. This is to prevent stats across Universes from changing."
    redirect_to root_url
  end
end
