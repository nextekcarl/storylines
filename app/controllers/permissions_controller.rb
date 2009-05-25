class PermissionsController < ApplicationController
  before_filter :login_required

  active_scaffold :permission do |config|
    config.columns = [:universe, :user, :rights]
  end

end
