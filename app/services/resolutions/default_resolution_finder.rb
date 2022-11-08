module Resolutions
	class DefaultResolutionFinder

		attr_reader :from_date, :to_date
		def initialize(args={})
			@from_date  = args[:from_date].present? ? args[:from_date] : oldest_date
			@to_date    = args[:to_date].present? ? args[:to_date] : Date.today
			@category_id = args[:category].present? ? args[:category].id : ""
		end

		def query!
			# stageable_ids = Staging
			# .where(stageable_type: "Resolution")
			# .where(date: date_from..date_to)
			# .pluck(:stageable_id)

			Resolution
			.where(category_id: @category_id)
			.where(date_approved: from_date..to_date)
			.sort_by(&:parsed_number)
		end

		def oldest_date
      Staging.where(stageable_type: "Resolution").order(:date).first.date
    end
	end
end