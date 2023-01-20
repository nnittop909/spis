class ConsecutiveTermFinder
	attr_accessor :termable, :position_id

	def initialize(args={})
		@termable        = args[:termable]
		@position_id     = args[:position_id]
	end

	def with_consecutive_terms?
		if consecutive_terms.present?
			return true
		else
			return false
		end
	end

	def consecutive_terms
		start_of_terms = []
		grouped_terms.each do |gt|
			if gt[1].count > 1
				start_of_terms << gt[1]
			end
		end
		start_of_terms # [[adf, adfa, asdfa]]
		terms = []
		start_of_terms.each do |start_of_term|
			consecutive_start_of_terms_arrays = start_of_term.chunk_while {|y, z| y + 3.years == z}.to_a.select {|y| y.count > 1}
			
			consecutive_start_of_terms_arrays.each do |consecutive_start_of_terms_array|
				consecutive_start_of_terms_array.each do |start_of_term|
					terms << @termable.terms.find_by(start_of_term: start_of_term)
				end
			end
		end
		terms
	end

	def first_term
		consecutive_terms.first
	end

	def second_term
		consecutive_terms.second
	end

	def final_term
		consecutive_terms.third
	end

	def count!
		if consecutive_terms.count > 1
			consecutive_terms.count
		else
			1
		end
	end

	def grouped_terms
		if @termable.terms.present?
			@termable.terms
			.where.not(start_of_term: nil)
			.order(:start_of_term)
			.pluck(:position_id, :start_of_term)
			.group_by(&:shift)
			.transform_values(&:flatten)
		end
	end
end