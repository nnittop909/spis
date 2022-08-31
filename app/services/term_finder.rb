class TermFinder
	attr_accessor :termable, :year

	def initialize(args={})
		@termable        = args[:termable]
		@year            = args[:year]
	end

	def by_term
		terms = []
		@termable.terms.each do |term|
			if included?(term) == true
				terms << term
			end
		end
		terms.last
	end

	def by_term_in_years
		by_term.in_year_range
	end

	def by_term_position
		if by_term.interim? == true
			"#{by_term.position} (Interim)"
		else
			by_term.position
		end
	end

	def by_term_appointment_status
		by_term.appointment_status.titleize
	end

	def by_term_party
		by_term.political_party
	end

	def current_term
		if @termable.terms.present?
			if @termable.terms.where.not(start_of_term: nil).present?
				@termable.terms.where.not(start_of_term: nil).order(:start_of_term).last.in_date_range
			end
		else
			"Please set term"
		end
	end

	def current_sp_term
		if @termable.sp_terms.present?
			if @termable.sp_terms.where.not(start_of_term: nil).present?
				@termable.sp_terms.where.not(start_of_term: nil).order(:start_of_term).last.in_date_range
			end
		else
			"Please set term"
		end
	end

	def current_term_in_years
		if @termable.terms.present?
			if @termable.terms.where.not(start_of_term: nil).present?
				@termable.terms.where.not(start_of_term: nil).order(:start_of_term).last.in_year_range
			end
		else
			"Please set term"
		end
	end

	def current_sp_term_in_years
		if @termable.sp_terms.present?
			if @termable.sp_terms.where.not(start_of_term: nil).present?
				@termable.sp_terms.where.not(start_of_term: nil).order(:start_of_term).last.in_year_range
			end
		else
			"Please set term"
		end
	end

	def current_position
		if @termable.terms.present?
			if @termable.terms.where.not(start_of_term: nil).present?
				term = @termable.terms.where.not(start_of_term: nil).order(:start_of_term).last
				if term.interim? == true
					"#{term.position} (Interim)"
				else
					term.position
				end
			end
		else
			"Please set term"
		end
	end

	def current_party
		if @termable.terms.present?
			if @termable.terms.where.not(start_of_term: nil).present?
				@termable.terms.where.not(start_of_term: nil).order(:start_of_term).last.political_party
			end
		else
			"Please set term"
		end
	end

	def current_appointment_status
		if @termable.terms.present?
			if @termable.terms.where.not(start_of_term: nil).present?
				@termable.terms.where.not(start_of_term: nil).order(:start_of_term).last.appointment_status.titleize
			end
		else
			"Please set term"
		end
	end

	def with_consecutive_terms?
		return false
		if @termable.terms.present?
			if @termable.terms.count > 1
				terms_in_years = []
				@termable.terms.order(:start_of_term).pluck(:start_of_term).each do |date|
					terms_in_years << date.year 
				end
				terms_in_years
				terms_in_years.chuck_while {|y, z| y + 3 == z}.to_a.select {|y| y.count > 1}.present?
			end
		end
	end

	def consecutive_terms
		if @termable.terms.present?
			if @termable.terms.count > 1
				terms_in_years = []
				@termable.terms.order(:start_of_term).pluck(:start_of_term).each do |date|
					terms_in_years << date.year 
				end
				terms_in_years
				years_array = terms_in_years.chuck_while {|y, z| y + 3 == z}.to_a.select {|y| y.count > 1}
				if years_array.present? 
					year = years_array.last
					"#{year.first - year.last + 3}"
				else

				end
			end
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