module Resolutions
	class SponsoredResolutionFinder

		attr_reader :sponsor, :from_date, :to_date
		def initialize(args={})
			@sponsor    = args[:sponsor]
			@from_date  = args[:from_date].present? ? args[:from_date] : oldest_date
			@to_date    = args[:to_date].present? ? args[:to_date] : Date.today
			@category_id = args[:category].present? ? args[:category].id : ""
		end

		def query!
			sponsorable_ids = sponsorship
			.where(sponsor_id: sponsor.id)
			.where(sponsorable_type: "Resolution")
			.pluck(:sponsorable_id)

			Resolution
			.where(category_id: @category_id)
			.where(id: sponsorable_ids)
			.where(date_approved: from_date..to_date)
			.sort_by(&:parsed_number)
		end

		def oldest_date
      Staging.where(stageable_type: "Resolution").order(:date).first.date
    end
	end
end