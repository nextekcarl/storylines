module CharactersHelper

  def updated_at_column(record)
    time_ago_in_words(record.updated_at) + " ago"
  end

  def description_show_column(record)
    record.description.to_s
  end

  def history_show_column(record)
    record.history.to_s
  end

  def organizations_show_column(record)
    if record.organizations.size > 0
      orgs = "<ul>"
      for org in record.organizations
        orgs += "<li>"
        orgs += link_to "#{org.name}", :controller => 'organizations', :action => 'show', :id => org
        orgs += "</li>"
      end
      orgs +="</ul>"
    else
      "-"
    end
  end

  def my_stats_column(record)
    unless record.my_stats.blank?
      textilize(record.my_stats.collect{|mystat| '|' + h(mystat.stat.name) + '|' + image_tag("stat_#{mystat.level}.png") + '|'}.join("\n"))
    else
      'none yet'
    end
  end

  def my_qualities_column(record)
    unless record.my_qualities.blank?
      textilize(record.my_qualities.collect{|myq| '|' + h(myq.quality.name) + '|' + image_tag("stat_#{myq.level}.png") + '|'}.join("\n"))
    else
      'none yet'
    end
  end

  def options_for_association_conditions(association)
    if association.name == :organizations
      ['organizations.universe_id = ?', current_user.current_universe_id]
    else
      super
    end
  end
end
