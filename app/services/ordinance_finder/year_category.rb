module OrdinanceFinder
	class YearCategory
		attr_reader :year, :category_id, :ordinances

    def initialize(args={})
      @ordinances ||= args[:ordinances]
      @year   = args[:year]
      @category_id   = args[:category_id]
    end

    def query
      ordinances
      .where(date_approved: from_date..to_date)
      .where(category_id: category_id)
      .sort_by(&:parsed_number)
      .reverse
    end

    def from_date
      ("#{@year}-01-01").to_date
    end

    def to_date
      ("#{@year}-12-31").to_date
    end
  end
end