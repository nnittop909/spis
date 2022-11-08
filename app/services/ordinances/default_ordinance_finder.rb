module Ordinances
	class DefaultOrdinanceFinder

		attr_reader :category, :from_date, :to_date
		def initialize(args={})
			@from_date  = args[:from_date].present? ? args[:from_date] : oldest_date
			@to_date    = args[:to_date].present? ? args[:to_date] : Date.today
			@category = args[:category]
		end

		def query!
			if @category.present?
				Ordinance
				.where(category_id: @category.id)
				.where(date_approved: from_date..to_date)
				.sort_by(&:parsed_number)
			else
				Ordinance
				.where(date_approved: from_date..to_date)
				.sort_by(&:parsed_number)
			end
		end

		def oldest_date
      Staging.where(stageable_type: "Ordinance").order(:date).first.date
    end
	end
end