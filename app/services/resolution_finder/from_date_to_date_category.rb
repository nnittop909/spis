module ResolutionFinder
	class FromDateToDateCategory
		attr_reader :from_date, :to_date, :category_id, :resolutions

    def initialize(args={})
      @resolutions ||= args[:resolutions]
      @from_date   = args[:from_date]
      @to_date     = args[:to_date]
      @category_ud = args[:category_ud]
    end

    def query
      resolutions
      .where(date_approved: from_date..to_date)
      .where(category_id: category_id)
      .sort_by(&:parsed_number)
      .reverse
    end
  end
end