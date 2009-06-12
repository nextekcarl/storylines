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

  def display_organizations(orig_organization)
    organization= orig_organization.root
	   ret = "<ul>"
		   if organization.parent_id == nil
  			ret += "<li>"
  			ret += "<strong>" if organization.id == orig_organization.id
  			ret += link_to organization.name, :action => 'show', :id => organization.id
  			ret += "</strong>" if organization.id == orig_organization.id
  			if organization.children.size > 0
  			  ret += find_all_suborganizations(organization, orig_organization)
			  end
  			ret += "</li>"
		   end
	   ret += "</ul>"
	   ret
    end

   def find_all_suborganizations(organization, orig_organization)
    if organization.children.size > 0
      ret = '<ul>'
      organization.children.each { |suborg|
        if suborg.children.size > 0
          ret += '<li>'
          ret += "<strong>" if suborg.id == orig_organization.id
          ret += link_to h(suborg.name), :action => 'show', :id => suborg
          ret += "</strong>" if suborg.id == orig_organization.id
          ret += find_all_suborganizations(suborg, orig_organization)
          ret += '</li>'
        else
          ret += '<li>'
          ret += "<strong>" if suborg.id == orig_organization.id
          ret += link_to h(suborg.name), :action => 'show', :id => suborg
          ret += "</strong>" if suborg.id == orig_organization.id
          ret += '</li>'
        end
        }
      ret += '</ul>'
    end
  end

end
