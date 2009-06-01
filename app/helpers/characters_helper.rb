module CharactersHelper

  def updated_at_column(record)
    time_ago_in_words(record.updated_at) + " ago"
  end

  def history_column(record)
    textilize(truncate(h(record.history), 200))
  end

  def description_column(record)
    textilize(truncate(h(record.description), 200))
  end

  def history_show_column(record)
    textilize(h record.history.to_s)
  end

  def description_show_column(record)
    textilize(h record.description)
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
