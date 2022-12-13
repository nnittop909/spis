module MinuteFinder
	class DefaultFinder
		attr_reader :minutes

    def initialize(args={})
      @minutes ||= args[:minutes]
      @to_date   = args[:to_date]
    end

    def query
      minutes.order(date: :desc)
    end
  end
end