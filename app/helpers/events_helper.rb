module EventsHelper

  def description_show_column(record)
    record.description.to_s
  end

  def location_id_column(record)
    record.location.name
  end
end
