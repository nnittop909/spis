module Searches
	class Results
		attr_accessor :record

		def initialize(args={})
			@record = args[:record]
		end

		def titles
			if record.class.name == "PgSearch::Document"
				if record.searchable_type == "Member"
					"#{record.searchable.name}" 
				elsif record.searchable_type == "Committee"
					"#{record.searchable.name}"
				elsif record.searchable_type == "Ordinance"
					"ORDINANCE# #{record.searchable.number}"
				elsif record.searchable_type == "Resolution"
					"RESOLUTION# #{record.searchable.number}"
				elsif record.searchable_type == "Minute"
					"#{record.searchable.title}"
				elsif record.searchable_type == "Document"
					"#{record.searchable.documentable_type}# #{record.searchable.documentable.number}"
				end
			else
				"#{record.filename}"
			end
		end

		def contents
			if record.class.name == "PgSearch::Document"
				case record.searchable_type
				when "Member"
					"#{record.searchable.name}"
				when "Committee"
					"#{record.searchable.name}"
				when "Ordinance"
					"#{record.searchable.title.truncate(150)} - Approved: #{record.searchable.date_approved.strftime("%B %e, %Y")}"
				when "Resolution"
					"#{record.searchable.title.truncate(150)} - Approved: #{record.searchable.date_approved.strftime("%B %e, %Y")}"
				when "Minute"
					"#{record.searchable.title}, Date: #{record.searchable.date.strftime("%B %e, %Y")}"
				when "Document"
					"#{record.searchable.name}"
				end
			else
				"Attached Document"
			end
		end
	end
end