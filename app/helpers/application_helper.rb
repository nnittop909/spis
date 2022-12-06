module ApplicationHelper

	def nav_link(controller, link, icon, text)
	  class_name = params[:controller].include?(controller) ? 'nav-item active' : 'nav-item'
	  icon_class = 'fas fa-fw ' + icon

	  content_tag(:li, :class => class_name) do
	    link_to link, class: "nav-link" do
    		concat(content_tag(:i, "", class: icon_class) + " " +
    		content_tag(:span, text))
	    end
	  end
	end

	def header_nav_link(controller, link, text)
	  class_name = params[:controller] == controller ? 'nav-item active' : 'nav-item'

	  content_tag(:li, :class => class_name) do
	    link_to link, class: "nav-link font-14" do
    		concat(content_tag(:i, "") + " " +
    		content_tag(:span, text))
	    end
	  end
	end

	def search_link(record)
		if record.class.name == "PgSearch::Document"
			if record.searchable_type == "Member"
				link = member_path(record.searchable.id)
			elsif record.searchable_type == "Committee"
				link = committee_path(record.searchable.id)
			elsif record.searchable_type == "Ordinance"
				link = ordinance_path(record.searchable.id)
			elsif record.searchable_type == "Resolution"
				link = resolution_path(record.searchable.id)
			elsif record.searchable_type == "Minute"
				link = minute_path(record.searchable.id)
			elsif record.searchable_type == "Document"
				link = rails_blob_path(record.searchable.document_file, disposition: "inline")
			end
		else
			link = rails_blob_path(record, disposition: "inline")
		end
	end

	def search_result_title(record)
		Searches::Results.new(record: record).titles
	end

	def search_result(record)
		Searches::Results.new(record: record).contents
	end

	def results_count_alert(records_count)
		if records_count >= 2
			"#{records_count} results found!"
		else
			"#{records_count} result found!"
		end
	end
end
