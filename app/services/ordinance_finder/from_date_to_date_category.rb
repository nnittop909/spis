module OrdinanceFinder
	class FromDateToDateCategory
		attr_reader :from_date, :to_date, :category_id, :ordinances

    def initialize(args={})
      @ordinances ||= args[:ordinances]
      @from_date   = args[:from_date]
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
  end
end