class QualitiesController < ApplicationController
  before_filter :login_required


  active_scaffold :quality do |config|
    config.columns = [:name]
    config.subform.layout = :vertical
    list.sorting = {:name => 'ASC'}
  end

  def update
    flash[:notice] = "Only the admin can edit quality names. This is to prevent qualities across Universes from changing."
    redirect_to :controller => :universes
  end

  def edit
    flash[:notice] = "Only the admin can edit quality names. This is to prevent qualities across Universes from changing."
    redirect_to :controller => :universes
  end
end
