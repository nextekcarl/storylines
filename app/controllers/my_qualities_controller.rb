class MyQualitiesController < ApplicationController
  before_filter  :login_required


  active_scaffold :my_qualities do |config|
    config.columns = [:quality, :character, :level]
    config.show.link.inline = false
    config.update.link.inline = false
    config.create.link.inline = false
    config.delete.link.inline = false
  end
end
