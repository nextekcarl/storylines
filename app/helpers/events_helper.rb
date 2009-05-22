module EventsHelper

  def description_show_column(record)
    record.description.to_s
  end

  def updated_at_column(record)
    time_ago_in_words(record.updated_at) + " ago"
  end

  def location_id_column(record)
    record.location.name
  end
end
