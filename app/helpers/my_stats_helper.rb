module MyStatsHelper
  def level_column(record)
    image_tag("stat_#{record.level}.png")
  end
end
