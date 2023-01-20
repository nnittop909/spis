module OrdinanceFinder
	class ToDate
		attr_reader :to_date, :ordinances

    def initialize(args={})
      @ordinances ||= args[:ordinances]
      @to_date     = args[:to_date]
    end

    def query
      ordinances
      .where(date_approved: from_date..to_date)
      .sort_by(&:parsed_number)
      .reverse
    end

    def from_date
      999.years.ago
    end
  end
end