module OrganizationsHelper
  def updated_at_column(record)
    time_ago_in_words(record.updated_at) + " ago"
  end

  def mission_statement_show_column(record)
    record.mission_statement.to_s
  end

  def agenda_show_column(record)
    record.agenda.to_s
  end

  def my_stats_column(record)
    record.my_stats.to_s
  end

  def options_for_association_conditions(association)
    if association.name == :parent
      ['organizations.universe_id = ?', current_user.current_universe_id]
    else
      super
    end
  end

end
