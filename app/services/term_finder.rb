class TermFinder
	attr_accessor :termable, :year

	def initialize(args={})
		@termable        = args[:termable]
		@year            = args[:year]
	end

	def by_term
		@termable.terms.where("start_of_term < ? AND end_of_term > ?", date, date).last
	end

	def by_term_in_years
		by_term.in_year_range
	end

	def by_term_position
		if by_term.interim? == true
			"#{by_term.position.name} (Interim)"
		else
			by_term.position.name
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

	def date
		("#{@year}-#{Date.today.month}-#{Date.today.day}").to_date
	end
end