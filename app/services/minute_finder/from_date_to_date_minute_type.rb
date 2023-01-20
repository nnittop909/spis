module MinuteFinder
	class FromDateToDateMinuteType
		attr_reader :to_date, :from_date, :minute_type, :minutes

    def initialize(args={})
      @minutes ||= args[:minutes]
      @from_date = args[:from_date]
      @to_date   = args[:to_date]
      @minute_type = args[:minute_type]
    end

    def query
      minutes
      .where(minute_type: minute_type)
      .where(date: from_date..to_date)
      .order(date: :desc)
    end
  end
end