module MunicipalOrdinanceFinder
	class YearMunicipality
		attr_reader :year, :municipality_id, :municipal_ordinances

    def initialize(args={})
      @municipal_ordinances ||= args[:municipal_ordinances]
      @year   = args[:year]
      @municipality_id   = args[:municipality_id]
    end

    def query
      municipal_ordinances
      .where(date_approved: from_date..to_date)
      .where(municipality_id: municipality_id)
      .order(year_and_number: :desc)
    end

    def from_date
      ("#{@year}-01-01").to_date
    end

    def to_date
      ("#{@year}-12-31").to_date
    end
  end
end