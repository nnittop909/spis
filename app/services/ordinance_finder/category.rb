module OrdinanceFinder
	class Category
		attr_reader :category_id, :ordinances

    def initialize(args={})
      @ordinances ||= args[:ordinances]
      @category_id   = args[:category_id]
    end

    def query
      ordinances
      .where(category_id: category_id)
      .sort_by(&:parsed_number)
      .reverse
    end
  end
end