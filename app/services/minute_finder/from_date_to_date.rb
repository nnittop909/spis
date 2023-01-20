module MinuteFinder
	class FromDateToDate
		attr_reader :to_date, :from_date, :minutes

    def initialize(args={})
      @minutes ||= args[:minutes]
      @from_date = args[:from_date]
      @to_date   = args[:to_date]
    end

    def query
      minutes
      .where(date: from_date..to_date)
      .order(date: :desc)
    end
  end
end