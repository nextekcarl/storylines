module ExperiencesHelper

  def updated_at_column(record)
    time_ago_in_words(record.updated_at) + " ago"
  end
  def description_show_column(record)
    record.description.to_s
  end

  def options_for_association_conditions(association)
    if association.name == :event
      ['events.universe_id = ?', current_user.current_universe_id]
    else
      super
    end
  end
end
