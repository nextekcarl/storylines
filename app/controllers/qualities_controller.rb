class QualitiesController < ApplicationController
  before_filter :login_required


  active_scaffold :quality do |config|
    config.columns = [:name]
    config.show.link.inline = false
    config.update.link.inline = false
    config.create.link.inline = false
    config.delete.link.inline = false
  end
end
