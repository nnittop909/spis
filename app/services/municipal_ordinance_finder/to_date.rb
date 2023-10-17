module MunicipalOrdinanceFinder
	class ToDate
		attr_reader :to_date, :municipal_ordinances

    def initialize(args={})
      @municipal_ordinances ||= args[:municipal_ordinances]
      @to_date     = args[:to_date]
    end

    def query
      municipal_ordinances
      .where(date_approved: from_date..to_date)
      .order(year_and_number: :desc)
    end

    def from_date
      999.years.ago
    end
  end
end