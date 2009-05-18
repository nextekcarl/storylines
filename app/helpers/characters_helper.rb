module CharactersHelper

  def history_show_column(record)
    record.history.to_s
  end

  def description_show_column(record)
    record.description.to_s
  end

  def description_column(record)
    truncate(record.description.to_s, 200)
  end

  def strength_column(record)
#    g = GChart.bar(:size => "80x20", :orientation =>:horizontal, :data => [[record.strength], [10]])
#    g.colors = [:green, :red]
#    image_tag(g.to_url)
     image_tag("stat_#{record.strength}.png")
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
