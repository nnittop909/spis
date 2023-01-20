module ResolutionFinder
	class FromDateToDate
		attr_reader :from_date, :to_date, :resolutions

    def initialize(args={})
      @resolutions ||= args[:resolutions]
      @from_date   = args[:from_date]
      @to_date     = args[:to_date]
    end

    def query
      resolutions
      .where(date_approved: from_date..to_date)
      .sort_by(&:parsed_number)
      .reverse
    end
  end
end