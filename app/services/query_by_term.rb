class QueryByTerm

	attr_reader :year
	def initialize(args={})
		@year = args[:year]
	end

	def query!
		members = []
		terms = Term.order(:position_id).where("start_of_term < ? AND end_of_term > ?", date, date)
		
		terms.each do |term|
			members << term.termable
		end
		members
	end

	def date
		("#{@year}-#{Date.today.month}-#{Date.today.day}").to_date
	end
end