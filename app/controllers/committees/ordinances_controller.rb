module Committees
	class OrdinancesController < ApplicationController

		def index
			@committee = Committee.find(params[:committee_id])
			@results = @member.sponsored_ordinances.sort_by(&:parsed_number).reverse
			@ordinances = Kaminari.paginate_array(@results).page(params[:page]).per(30)
		end
	end
end