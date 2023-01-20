module MinuteFinder
	class ToDate
		attr_reader :to_date, :minutes

    def initialize(args={})
      @minutes ||= args[:minutes]
      @to_date   = args[:to_date]
    end

    def query
      minutes
      .where(date: from_date..to_date)
      .order(date: :desc)
    end

    def from_date
      99.years.ago
    end
  end
end