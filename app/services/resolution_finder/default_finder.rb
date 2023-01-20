module ResolutionFinder
	class DefaultFinder
		attr_reader :resolutions

    def initialize(args={})
      @resolutions ||= args[:resolutions]
    end

    def query
      resolutions.all
      .sort_by(&:parsed_number)
      .reverse
    end
  end
end