module Minutes
	class DefaultMinuteFinder

		attr_reader :from_date, :to_date
		def initialize(args={})
			@from_date  = args[:from_date].present? ? args[:from_date] : 999.years.ago
			@to_date    = args[:to_date].present? ? args[:to_date] : Date.today
		end

		def query!
			Minute.where(date: from_date..to_date).order(date: :desc)
		end
	end
end