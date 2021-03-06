module UserlimitsHelper

  def rights_column(record)
    record.rights_in_words
  end

  def rights_form_column(record, input_name)
    select_tag :record, '<option value="1">view only</option>
      <option value="2">create and view</option>
      <option value="3">full edit</option>', {:name => input_name}
  end

  def user_form_column(record, input_name)
    @universe = current_user.current_universe
    @permitted_users = Array.new
    unless @universe.userlimits.nil?
      @universe.userlimits.each do |permission|
        @permitted_users << permission.user.id
      end
    end
    if @permitted_users.empty?
      @users = User.find(:all, :conditions => ['id != ?', ["#{current_user.id}"]])
    elsif @permitted_users.size == 1
      @users = User.find(:all, :conditions => ["id != ? and id != #{@permitted_users[0]}", ["#{current_user.id}" ]])
    else
      @users = User.find(:all, :conditions => ["id != ? and id NOT IN (#{@permitted_users.join(',')})", ["#{current_user.id}"]])
    end
    collection_select :record, :user_id, @users, :id, :username
  end
end
