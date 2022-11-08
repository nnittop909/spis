module Committees
	class MembersFinder
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
			if by_term.committee_members.chairperson.present?
				by_term.committee_members.chairperson.last.member
			end
		end

		def vice_chairperson
			if by_term.committee_members.vice_chairperson.present?
				by_term.committee_members.vice_chairperson.last.member
			end
		end

		def members
			ids = by_term.committee_members.regular.pluck(:id)
			Member.where(id: ids)
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