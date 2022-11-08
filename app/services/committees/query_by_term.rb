module Committees
	class QueryByTerm

		attr_reader :year
		def initialize(args={})
			@year = args[:year]
		end

		def query!
			terms = []
			committees = []
			CommitteeMembership.order(:name).all.each do |term|
				if included?(term) == true
					terms << term
				end
			end
			terms.each do |term|
				committees << term.committee
			end
			committees
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