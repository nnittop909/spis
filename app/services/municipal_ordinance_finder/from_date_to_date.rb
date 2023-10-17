module MunicipalOrdinanceFinder
	class FromDateToDate
		attr_reader :from_date, :to_date, :municipal_ordinances

    def initialize(args={})
      @municipal_ordinances ||= args[:municipal_ordinances]
      @from_date   = args[:from_date]
      @to_date     = args[:to_date]
    end

    def query
      municipal_ordinances
      .where(date_approved: from_date..to_date)
      .order(year_and_number: :desc)
    end
  end
end