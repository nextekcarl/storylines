class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  before_filter :authorized?, :only => [:edit, :update, :destroy]

  active_scaffold :user do |config|
    config.columns = [:username]
    config.subform.columns.exclude [:username]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def conditions_for_collection
    ['users.id = ?', ["#{current_user.id}"]]
  end

  protected

  def authorized?
    #Only works correctly if not using ajax, otherwise it generates a 500 error.
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      flash[:error] = "You may only edit your own account."
      redirect_to :controller => :universes
      return false
    end
  end
end
