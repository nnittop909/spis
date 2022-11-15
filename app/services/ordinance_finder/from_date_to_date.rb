module OrdinanceFinder
	class FromDateToDate
		attr_reader :from_date, :to_date, :ordinances

    def initialize(args={})
      @ordinances ||= args[:ordinances]
      @from_date   = args[:from_date]
      @to_date     = args[:to_date]
    end

    def query
      ordinances
      .where(date_approved: from_date..to_date)
      .sort_by(&:parsed_number)
      .reverse
    end
  end
end