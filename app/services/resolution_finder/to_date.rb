module ResolutionFinder
	class ToDate
		attr_reader :to_date, :resolutions

    def initialize(args={})
      @resolutions ||= args[:resolutions]
      @to_date     = args[:to_date]
    end

    def query
      resolutions
      .where(date_approved: from_date..to_date)
      .sort_by(&:parsed_number)
      .reverse
    end

    def from_date
      999.years.ago
    end
  end
end