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

  def display_organizations(organization)
    organization= organization.root
	   ret = "<ul>"
		   if organization.parent_id == nil
  			ret += "<li>"
  			ret += link_to organization.name
  			if organization.children.size > 0
  			  ret += find_all_suborganizations(organization)
			  end
  			ret += "</li>"
		   end
	   ret += "</ul>"
	   ret
    end

   def find_all_suborganizations(organization)
    if organization.children.size > 0
      ret = '<ul>'
      organization.children.each { |suborg|
        if suborg.children.size > 0
          ret += '<li>'
          ret += link_to h(suborg.name), :action => 'show', :id => suborg
          ret += find_all_suborganizations(suborg)
          ret += '</li>'
        else
          ret += '<li>'
          ret += link_to h(suborg.name), :action => 'show', :id => suborg
          ret += '</li>'
        end
        }
      ret += '</ul>'
    end
  end

end
