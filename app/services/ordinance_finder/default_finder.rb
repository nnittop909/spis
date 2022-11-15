module OrdinanceFinder
	class DefaultFinder
		attr_reader :ordinances

    def initialize(args={})
      @ordinances ||= args[:ordinances]
    end

    def query
      ordinances.all
      .sort_by(&:parsed_number)
      .reverse
    end
  end
end