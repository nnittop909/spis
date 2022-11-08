module Ordinances
	class AuthoredOrdinanceFinder

		attr_reader :author, :from_date, :to_date
		def initialize(args={})
			@author     = args[:author]
			@from_date  = args[:from_date].present? ? args[:from_date] : oldest_date
			@to_date    = args[:to_date].present? ? args[:to_date] : Date.today
			@category_id = args[:category].present? ? args[:category].id : ""
		end

		def query!
			authorable_ids = Authorship
			.where(author_id: author.id)
			.where(authorable_type: "Ordinance")
			.pluck(:authorable_id)

			Ordinance
			.where(category_id: @category_id)
			.where(id: authorable_ids)
			.where(date_approved: from_date..to_date)
			.sort_by(&:parsed_number)
		end

		def oldest_date
      Staging.where(stageable_type: "Ordinance").order(:date).first.date
    end
	end
end