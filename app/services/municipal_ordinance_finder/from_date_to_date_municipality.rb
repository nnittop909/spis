module MunicipalOrdinanceFinder
	class FromDateToDateMunicipality
		attr_reader :from_date, :to_date, :municipality_id, :municipal_ordinances

    def initialize(args={})
      @municipal_ordinances ||= args[:municipal_ordinances]
      @from_date   = args[:from_date]
      @to_date     = args[:to_date]
      @municipality_id = args[:municipality_id]
    end

    def query
      municipal_ordinances
      .where(date_approved: from_date..to_date)
      .where(municipality_id: municipality_id)
      .order(year_and_number: :desc)
    end
  end
end