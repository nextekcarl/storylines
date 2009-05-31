class MyStatsController < ApplicationController
  before_filter :login_required


  active_scaffold :my_stat do |config|
    config.columns = [:character, :stat, :level]
    config.show.link.inline = false
    config.update.link.inline = false
    config.create.link.inline = false
    config.delete.link.inline = false
  end
end
