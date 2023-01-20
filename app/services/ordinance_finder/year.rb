module OrdinanceFinder
	class Year
		attr_reader :year, :ordinances

    def initialize(args={})
      @ordinances ||= args[:ordinances]
      @year   = args[:year]
    end

    def query
      ordinances
      .where(date_approved: from_date..to_date)
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