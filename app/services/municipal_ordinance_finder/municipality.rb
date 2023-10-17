module MunicipalOrdinanceFinder
	class Municipality
		attr_reader :municipality_id, :municipal_ordinances

    def initialize(args={})
      @municipal_ordinances ||= args[:municipal_ordinances]
      @municipality_id   = args[:municipality_id]
    end

    def query
      municipal_ordinances
      .where(municipality_id: municipality_id)
      .order(year_and_number: :desc)
    end
  end
end