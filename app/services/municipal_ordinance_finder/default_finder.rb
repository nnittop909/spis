module MunicipalOrdinanceFinder
	class DefaultFinder
		attr_reader :municipal_ordinances

    def initialize(args={})
      @municipal_ordinances ||= args[:municipal_ordinances]
    end

    def query
      municipal_ordinances
      .order(year_and_number: :desc)
    end
  end
end