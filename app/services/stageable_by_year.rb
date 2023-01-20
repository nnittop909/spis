class StageableByYear

	attr_reader :stageable_type, :year
	def initialize(args={})
		@year = args[:year]
		@stageable_type = args[:stageable_type]
	end

	def query!
		stageable_ids = Staging.where(stageable_type: @stageable_type).where(date: date_from..date_to).pluck(:stageable_id)
		@stageable_type.constantize.where(id: stageable_ids).sort_by(&:parsed_number).reverse
	end

	def date_from
		("#{@year}-01-01").to_date
	end

	def date_to
		("#{@year}-12-31").to_date
	end
end