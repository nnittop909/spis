module Minutes
	class MinuteTypeFinder

		attr_reader :from_date, :to_date, :minute_type
		def initialize(args={})
			@from_date  = args[:from_date].present? ? args[:from_date] : 999.years.ago
			@to_date    = args[:to_date].present? ? args[:to_date] : Date.today
			@minute_type = args[:minute_type]
		end

		def query!
			Minute
			.where(minute_type: minute_type)
			.where(date: from_date..to_date)
			.order(date: :desc)
		end
	end
end