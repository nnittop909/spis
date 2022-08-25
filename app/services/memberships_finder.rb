class MembershipsFinder

	attr_reader :termables, :date
	def initialize(args={})
		@termables = args[:termables]
		@date     = args[:date]
	end

	def query!
		terms = []
		@termables.each do |term|
			if included?(term) == true
				terms << term
			end
		end
		terms.uniq
	end

	def current
		terms = []
		@termables.each do |term|
			if included?(term) == true
				terms << term
			end
		end
		if terms.blank?
			@termables.order(:start_of_term).last
		else
			terms.last
		end
	end

	def included?(term)
		(term.start_of_term..term.end_of_term).include?(@date)
	end
end