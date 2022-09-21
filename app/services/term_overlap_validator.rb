class TermOverlapValidator

	attr_reader :validatable_start_date, :validatable_end_date, :termable
	def initialize(args={})
		@validatable_start_date = args[:validatable_start_date]
		@validatable_end_date = args[:validatable_end_date]
		@termable = args[:termable]
	end

	def overlapped_terms
		terms = []
		if termable_terms.present?
			termable_terms.each do |term|
				if overlapped?(term) == true
					terms << term
				end
			end
		end
		terms.uniq
	end

	def overlapped?(term)
		(validatable_start_date..validatable_end_date).overlaps?(term.start_of_term..term.end_of_term)
	end

	def overlapped_terms_in_date_range
		overlapped_terms.last.in_date_range
	end

	def error_message
		if overlapped_terms.present?
      "Term conflict identified: #{overlapped_terms_in_date_range}."
    end
	end

	def termable_terms
		if termable.class.name == "Committee"
			termable.committee_memberships
		else
			termable.terms
		end
	end
end