module OrdinanceFinder
	class ToDateCategory
		attr_reader :to_date, :category_id, :ordinances

    def initialize(args={})
      @ordinances ||= args[:ordinances]
      @to_date     = args[:to_date]
      @category_id = args[:category_id]
    end

    def query
      ordinances
      .where(date_approved: from_date..to_date)
      .where(category_id: category_id)
      .sort_by(&:parsed_number)
      .reverse
    end

    def from_date
      999.years.ago
    end
  end
end