class RequiredStatsController < ApplicationController
  before_filter :login_required


  active_scaffold :required_stat do |config|
    config.columns = [:stat, :universe]
    config.show.link.inline = false
    config.update.link.inline = false
    config.create.link.inline = false
    config.delete.link.inline = false
  end
end
