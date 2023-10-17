module MunicipalOrdinances
	class DefaultOrdinanceFinder

		attr_reader :from_date, :to_date
		def initialize(args={})
			@from_date  = args[:from_date].present? ? args[:from_date] : oldest_date
			@to_date    = args[:to_date].present? ? args[:to_date] : Date.today
			@series    = args[:series]
			@municipality = args[:municipality]
		end

		def query!
			if @municipality.present?
				MunicipalOrdinance
				.where(municipality_id: @municipality.id)
				.where(date_approved: from_date..to_date)
				.order(year_and_number: :desc)
			else
				MunicipalOrdinance
				.where(date_approved: from_date..to_date)
				.order(year_and_number: :desc)
			end
		end

		def oldest_date
			if MunicipalOrdinance.all.present?
      	MunicipalOrdinance.order(:date_approved).first.date_approved
      else
      	999.years.ago.to_date
      end
    end
	end
end