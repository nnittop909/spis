module MinuteFinder
	class ToDateMinuteType
		attr_reader :to_date, :minute_type, :minutes

    def initialize(args={})
      @minutes ||= args[:minutes]
      @to_date   = args[:to_date]
      @minute_type = args[:minute_type]
    end

    def query
      minutes
      .where(minute_type: minute_type)
      .where(date: from_date..to_date)
      .order(date: :desc)
    end

    def from_date
      99.years.ago
    end
  end
end