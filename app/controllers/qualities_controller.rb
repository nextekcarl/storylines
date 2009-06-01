class QualitiesController < ApplicationController
  before_filter :login_required


  active_scaffold :quality do |config|
    config.columns = [:name]
    config.show.link.inline = false
    config.update.link.inline = false
    config.create.link.inline = false
    config.delete.link.inline = false
  end

  def update
    flash[:notice] = "Only the admin can edit quality names. This is to prevent qualities across Universes from changing."
    redirect_to root_url
  end

  def edit
    flash[:notice] = "Only the admin can edit quality names. This is to prevent qualities across Universes from changing."
    redirect_to root_url
  end
end
