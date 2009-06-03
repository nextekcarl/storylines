module CharactersHelper

  def updated_at_column(record)
    time_ago_in_words(record.updated_at) + " ago"
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
end
