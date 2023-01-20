module Committees
	class TermFinder
		attr_accessor :termable, :year

		def initialize(args={})
			@termable        = args[:termable]
			@year            = args[:year]
		end

		def by_term
			terms = []
			@termable.committee_memberships.each do |term|
				if included?(term) == true
					terms << term
				end
			end
			terms.last
		end

		def chairperson
			by_term.committee_members.chairperson.last
		end

		def vice_chairperson
			by_term.committee_members.vice_chairperson.last
		end

		def by_term_in_years
			by_term.in_year_range
		end

		def current_term
			if @termable.committee_memberships.present?
				if @termable.committee_memberships.where.not(start_of_term: nil).present?
					@termable.committee_memberships.where.not(start_of_term: nil).order(:start_of_term).last.in_date_range
				end
			else
				"Please set term"
			end
		end

		def current_term_in_years
			if @termable.committee_memberships.present?
				if @termable.committee_memberships.where.not(start_of_term: nil).present?
					@termable.committee_memberships.where.not(start_of_term: nil).order(:start_of_term).last.in_year_range
				end
			else
				"Please set term"
			end
		end

		def included?(term)
			if term.start_of_term.present? && term.end_of_term.present?
				(term.start_of_term..term.end_of_term).include?(date)
			else
				false
			end
		end

		def date
			("#{@year}-#{Date.today.month}-#{Date.today.day}").to_date
		end
	end
end