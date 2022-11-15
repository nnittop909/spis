module ResolutionFinder
	class Category
		attr_reader :category_id, :resolutions

    def initialize(args={})
      @resolutions ||= args[:resolutions]
      @category_id   = args[:category_id]
    end

    def query
      resolutions
      .where(category_id: category_id)
      .sort_by(&:parsed_number)
      .reverse
    end
  end
end