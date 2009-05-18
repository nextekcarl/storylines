module LocationsHelper

  def description_show_column(record)
    record.description.to_s
  end

  def description_column(record)
    truncate(record.description.to_s, :length=>300)
  end
end
