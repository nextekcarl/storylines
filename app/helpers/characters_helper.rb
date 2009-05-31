module CharactersHelper

  def updated_at_column(record)
    time_ago_in_words(record.updated_at) + " ago"
  end

  def history_show_column(record)
    textilize(record.history.to_s)
  end

  def description_show_column(record)
    textilize(record.description)
  end

  def description_column(record)
    textilize(record.description)
  end

  def strength_column(record)
     image_tag("stat_#{record.strength}.png")
  end

  def my_stats_column(record)
    record.my_stats.collect{|mystat| h(mystat.stat.name) + image_tag("stat_#{mystat.level}.png")}.join('<br/>')
  end

  def my_qualities_column(record)
    record.my_qualities.collect{|myq| h(myq.quality.name) + image_tag("stat_#{myq.level}.png")}.join('<br/>')
  end

  def cunning_column(record)
    image_tag("stat_#{record.cunning}.png")
  end

  def agility_column(record)
    image_tag("stat_#{record.agility}.png")
  end

  def endurance_column(record)
    image_tag("stat_#{record.endurance}.png")
  end

  def charisma_column(record)
    image_tag("stat_#{record.charisma}.png")
  end
end
